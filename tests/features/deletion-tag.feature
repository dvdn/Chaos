Feature: update tag

    Scenario: Delete tag
        Given I have the following tags in my database:
            | name      | created_at          | updated_at          | is_visible  | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True        | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True        | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        When I delete "/tags/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "204"


    Scenario: Delete tag with id not valid
        Given I have the following tags in my database:
            | name      | created_at          | updated_at          | is_visible  | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True        | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True        | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |
        When I delete "/tags/7ffab232-3d48-aa2c-22f8680230b6"
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"
