SELECT mustache('
    CREATE TABLE {{{ table_name }}} (
        {{{ table_name }}}_id SERIAL PRIMARY KEY
        {{ #cols }}
        , {{{ def }}}
        {{ /cols }}
    );'
    , '{
            "table_name": "my_table"
            , "cols": [ 
                { "def": "t text" }
                , { "def": "i int" }
            ]
       }'
);
