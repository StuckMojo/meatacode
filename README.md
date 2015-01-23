Postgresql SQL template system.

> So, I was trying to use mustache.js in PG by defining a V8 function that imports it. Older versions worked fine, but in newer versions they use a class factory and I can't figure out how to reference the mustache stuff that it creates. Apparently I need to know how our V8 implementation does exports.

If you define a variable named "exports" before the Mustache factory
code then it'll make it think it's loading in a CommonJS environment
and the "exports" variable will be populated with the Mustache
methods.

I'm not too familiar with PLV8 (so I'm not sure if there's a
better/direct way to support modules) but the following works fine:

CREATE OR REPLACE FUNCTION mustache(template text, view json)
    RETURNS TEXT
    LANGUAGE plv8
    IMMUTABLE
    STRICT
AS $BODY$
var exports = {};
// Copy/paste https://raw.githubusercontent.com/janl/mustache.js/master/mustache.js
var Mustache = exports;
return Mustache.render(template, view);
$BODY$;

test=> SELECT mustache('test: {{foo}}', '{"foo": "bar"}'::json);
 mustache
-----------
 test: bar
(1 row)

