---
date: 2016-03-07T07:43:55+02:00
description: "Logstash Forwarder => Filebeat"
title: Migrating from logstash forwarder to beat (filebeat)
categories: [logstash,logstash-forwarder,beat,beats,filebeat,monitoring,logging,ansible]
---

## Logstash forwarder did a great job

Alas, it had his faults.

If you'd have push backs from your logstash server(s), the logstash forwarder would enter a frenzy mode, keeping all unreported files open (including file handlers).

If you then had a sane log rotating policy, the files would be deleted, but the forwarder would keep the file handles open, causing the disk to fill up.

There was a hidden flag called `"dead time"` where you could configure how the maximum age of the files that the forwarder would keep open, but that didn't always work either.

The only quick solution was to restart the forwarder.

As with that bug, soon all critical bug issues on the forwarder repository had the same message:

> This will be fixed in the coming beats release.

I'd been waiting for some free time to upgrade our ([BigPanda](https://bigpanda.io)) logging pipeline to [beats](https://www.elastic.co/products/beats) ([filebeat](https://www.elastic.co/products/beats/filebeat)), and finally, the opportunity represented itself.

Here's some notes from the upgrade procedure.

### Config files are now YAML

IMHO, a welcome change.

### You'll need to define another logstash input `logstash-input-filebeat`

Which is almost identical to the `logstash-input-lumberjack`, but notice the `ssl => true` which needs to be set.

The following example is the Ansible Jinja2 template we use for the filebeat logstash input:

```ruby
input {
  beats {
    codec => plain {
       charset => "UTF-8"
    }
    #codec => "rubydebug"
    port => {{ beats_port }}
    ssl => true
    ssl_certificate => "{{ logstash_certs_dest_dir }}/{{ cert_name }}.crt"
    ssl_key => "{{ logstash_certs_dest_dir }}/{{ cert_name }}.key"
    add_field => { "logstash_server" => "{{ inventory_hostname }}"  }
  }
}
```

#### Back to filebeats

### There's now an option to include a `config_dir`!

Yay! Finally a way to do a `conf.d` type solution.

### Remember "dead time"?

It's now called `ignore_older`, and guess what, it's actually honored and working!

Here's an example of the filebeat config (again an Ansible Jinja2 template):

Notice the indentation of the `output` option, which is not shown in the official docs for some reason.

```yaml
---
filebeat:
  config_dir: "{{ beats_config_d_dir }}"
  spool_size: {{ beats_spool_size }}
output:
  logstash:
    hosts: [
      {% for item in (logstash_servers | default([])) %}
        "{{ item }}:{{ beats_port }}"
          {% if not loop.last %}
              ,
          {% endif %}
      {% endfor %}
    ]
    loadbalance: true
    worker: {{ [1, ansible_processor_vcpus - 1] | max }}
    timeout: {{ beats_timeout }}
    tls:
      certificate: "{{ beats_certs_dir }}/{{ cert_name }}.crt"
      certificate_key: "{{ beats_certs_dir }}/{{ cert_name }}.key"
```

In our case, we changed `{{ beats_port }}` from the default `5044` port to the port used by logstash forwarder (`5043`), just to simplify security groups and port openings.

And this is one of the filebeat configs loaded in the `config_dir`:

```yaml
---
filebeat:
  prospectors:
    - fields_under_root: true
      ignore_older: "{{ beats_dead_time }}"
      harverster_buffer_size: "{{ beats_harvester_buffer_size }}"
      paths:
{% for item in beats_config_paths %}
        - "{{ item }}"
{% endfor %}
      fields:
        type: "{{ beats_config_type }}"
        index_type: "{{ beats_config_index_type }}"
```

Small FYI, Beats automagically adds `beat.name` and `beat.hostname` to the fields.

### To Summarize:

* Config moved from json-ish to YAML.
* File handle locks have improved drastically
* The filebeat agent now load balances its output to all logstash servers, which spreads the load more equally between them.
* Replace `file` with `source` in your logstash filters if you grok by it.

