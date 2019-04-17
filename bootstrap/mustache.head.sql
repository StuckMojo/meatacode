CREATE OR REPLACE FUNCTION mustache(template text, view json)
    RETURNS TEXT
    LANGUAGE plv8
    IMMUTABLE
    STRICT
AS $$

