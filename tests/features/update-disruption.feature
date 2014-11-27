Feature: update disruption

   Scenario: update disruption with id not valid

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/AA-BB" with:
        """
        {"reference":"foobarz","publication_period": {"begin":"2014-06-24T13:35:00Z","end":"2014-07-08T18:00:00Z"}, "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}}
        """
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"

   Scenario: update disruption with localization not in navitia

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6" with:
        """
        {"reference":"foobarz","publication_period": {"begin":"2014-06-24T13:35:00Z","end":"2014-07-08T18:00:00Z"}, "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "localization":[{"id": "AA", "type": "stop_area"}]}
        """
        Then the status code should be "404"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "ptobject AA doesn't exist"

   Scenario: update disruption without reference

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6" with:
        """
        {"publication_period": {"begin":"2014-06-24T13:35:00Z","end":"2014-07-08T18:00:00Z"}, "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}}
        """
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "'reference' is a required property"


   Scenario: I can update the wording of a cause

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6" with:
        """
        {"reference":"foobarz","publication_period": {"begin":"2014-06-24T13:35:00Z","end":"2014-07-08T18:00:00Z"}, "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.publication_period.begin" should be "2014-06-24T13:35:00Z"
        And the field "disruption.publication_period.end" should be "2014-07-08T18:00:00Z"

   Scenario: I can update with tag and associate_disruption_tag is empty

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following tags in my database:
            | name      |  created_at          | updated_at          | is_visible | id                                   |
            | weather   |  2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    |  2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "7ffab230-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 1
        And the field "disruption.tags.0.id" should be "7ffab230-3d48-4eea-aa2c-22f8680230b6"
        And the field "disruption.tags.0.name" should be "weather"

   Scenario: I can update with add tag and associate_disruption_tag is not empty (1 associate_disruption_tag)

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following tags in my database:
            | name      |  created_at          | updated_at          | is_visible | id                                   |
            | weather   |  2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 5ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    |  2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "5ffab230-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 1

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "5ffab230-3d48-4eea-aa2c-22f8680230b6"}, {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 2


   Scenario: I can update with delete tag and associate_disruption_tag is not empty (2 associate_disruption_tag)

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following tags in my database:
            | name      |  created_at          | updated_at          | is_visible | id                                   |
            | weather   |  2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 5ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    |  2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "5ffab230-3d48-4eea-aa2c-22f8680230b6"}, {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 2

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "5ffab230-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 1
        And the field "disruption.tags.0.id" should be "5ffab230-3d48-4eea-aa2c-22f8680230b6"
        And the field "disruption.tags.0.name" should be "weather"

   Scenario: I can update with delete 2 tags and associate_disruption_tag is not empty (2 associate_disruption_tag)

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date |cause_id                              |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | None                   | None                 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following tags in my database:
            | name      |  created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   |  2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 5ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    |  2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}, "tags":[{"id": "5ffab230-3d48-4eea-aa2c-22f8680230b6"}, {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 2

        When I put to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3" with:
        """
        {"reference":"foobarz", "cause":{"id":"7ffab230-3d48-4eea-aa2c-22f8680230b6"}}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "disruption.tags" should have a size of 0

        I fill in header "X-Customer-Id" with "5"
        When I get "/tags"
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "tags" should have a size of 2