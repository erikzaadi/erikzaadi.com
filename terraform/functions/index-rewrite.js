// CloudFront viewer-request function, replaces the S3 website endpoint behavior
// now that the buckets are private (REST origin via OAC):
//   /path/  -> serve /path/index.html
//   /path   -> 301 to /path/ (keeps relative links in slide decks working)
//   /a.css  -> unchanged
function handler(event) {
    var request = event.request;
    var uri = request.uri;

    if (uri.endsWith('/')) {
        request.uri = uri + 'index.html';
        return request;
    }

    var lastSegment = uri.substring(uri.lastIndexOf('/') + 1);
    if (lastSegment.indexOf('.') === -1) {
        var query = Object.keys(request.querystring).map(function (key) {
            var param = request.querystring[key];
            return param.value === '' ? key : key + '=' + param.value;
        }).join('&');

        return {
            statusCode: 301,
            statusDescription: 'Moved Permanently',
            headers: {
                location: { value: uri + '/' + (query ? '?' + query : '') },
            },
        };
    }

    return request;
}
