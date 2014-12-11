Feature: Manipulate impacts in a Disruption

    Scenario: Add an impact in a disruption with one object invalid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:JDR:2AAA","type": "network"}]}
        """
        Then the status code should be "404"
        And the header "Content-Type" should be "application/json"

    Scenario: Add an impact in a disruption with one object valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:JDR:2","type": "network"}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.id" should be "network:JDR:2"
        And the field "impact.objects.0.type" should be "network"
        And the field "impact.objects.0.name" should be "SNCF"

    Scenario: Add an impact in a disruption with one object in database which does not exist in navitia

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        | severity_id                         |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d48-4eea-aa2c-22f8680230b6 | a750994c-01fe-11e4-b4fb-080027079ff3 |7ffab232-3d48-4eea-aa2c-22f8680230b6 |

    Scenario: Add an impact on stop area

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "stop_area:JDR:SA:PTVIN","type": "stop_area"}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.0.type" should be "stop_area"
        And the field "impact.objects.0.name" should be "Porte de Vincennes"

    Scenario: Add an impact on line

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "line:JDR:M1","type": "line"}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.id" should be "line:JDR:M1"
        And the field "impact.objects.0.type" should be "line"
        And the field "impact.objects.0.name" should be "Château de Vincennes - La Défense"

    Scenario: Add an ptobject in a impact (1 ptobject)

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   |cause_id                              | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 2ffab230-3d48-4eea-aa2c-22f8680230b6 | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 3ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 2ffab230-3d48-4eea-aa2c-22f8680230b6 |3ffab232-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/2ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "3ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:JDR:2","type": "network"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 1
        And the field "impact.objects.0.id" should be "network:JDR:2"
        And the field "impact.objects.0.type" should be "network"

    Scenario: add ptobject in a impact (2 ptobject)

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   |cause_id                              | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 2ffab230-3d48-4eea-aa2c-22f8680230b6 | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 3ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 2ffab230-3d48-4eea-aa2c-22f8680230b6 |3ffab232-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following ptobject in my database:
            | type   | uri                    | created_at          | updated_at          | id                                         |
            | network| network:JDR:2          | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6       |

        Given I have the relation associate_impact_pt_object in my database:
            | pt_object_id                               | impact_id                            |
            | 1ffab232-3d48-4eea-aa2c-22f8680230b6       | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/2ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "3ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:JDR:2","type": "network"}, {"id": "network:JDR:1","type": "network"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 2

    Scenario: delete one ptobject in a impact (2 ptobject)

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   |cause_id                              | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 2ffab230-3d48-4eea-aa2c-22f8680230b6 | 1ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 3ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 2ffab230-3d48-4eea-aa2c-22f8680230b6 |3ffab232-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following ptobject in my database:
            | type   | uri                    | created_at          | updated_at          | id                                         |
            | network| network:JDR:2          | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | network| network:JDR:1          | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | 2ffab232-3d48-4eea-aa2c-22f8680230b6       |

        Given I have the relation associate_impact_pt_object in my database:
            | pt_object_id                               | impact_id                            |
            | 1ffab232-3d48-4eea-aa2c-22f8680230b6       | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/2ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "3ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:JDR:2","type": "network"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 1
        And the field "impact.objects.0.id" should be "network:JDR:2"
        And the field "impact.objects.0.type" should be "network"

    Scenario: Add an impact in a disruption with one object line_section valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:M1", "type":"line_section","line_section": {"line":{"id":"line:JDR:M1","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:PTVIN", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, "sens":0 }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.type" should be "line_section"
        And the field "impact.objects.0.line_section.0.line.id" should be "line:JDR:M1"
        And the field "impact.objects.0.line_section.0.start_point.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.0.line_section.0.end_point.id" should be "stop_area:JDR:SA:BERAU"

    Scenario: Add an impact in a disruption with one object line_section and another ptobject valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:M1", "type":"line"},{"id":"line:JDR:M1", "type":"line_section","line_section": {"line":{"id":"line:JDR:M1","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:PTVIN", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, "sens":0 }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.type" should be "line"
        And the field "impact.objects.0.id" should be "line:JDR:M1"
        And the field "impact.objects.1.type" should be "line_section"
        And the field "impact.objects.1.line_section.0.line.id" should be "line:JDR:M1"
        And the field "impact.objects.1.line_section.0.start_point.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.1.line_section.0.end_point.id" should be "stop_area:JDR:SA:BERAU"

    Scenario: Add an impact in a disruption with one object line_section with route valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:M1", "type":"line_section","line_section": {"line":{"id":"line:JDR:M1","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:PTVIN", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, "sens":0, "routes":[{"type":"route", "id":"route:JDR:M14"}, {"type":"route", "id":"route:JDR:M1"}] }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.type" should be "line_section"
        And the field "impact.objects.0.line_section.0.line.id" should be "line:JDR:M1"
        And the field "impact.objects.0.line_section.0.start_point.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.0.line_section.0.end_point.id" should be "stop_area:JDR:SA:BERAU"
        And the field "impact.objects.0.line_section.0.routes.0.type" should be "route"
        And the field "impact.objects.0.line_section.0.routes.0.id" should be "route:JDR:M14"
        And the field "impact.objects.0.line_section.0.routes.1.type" should be "route"
        And the field "impact.objects.0.line_section.0.routes.1.id" should be "route:JDR:M1"

    Scenario: Add an impact in a disruption with one object, line_section with routes valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:M1", "type":"line"},{"id":"line:JDR:M1", "type":"line_section","line_section": {"line":{"id":"line:JDR:M1","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:PTVIN", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, "sens":0, "routes":[{"type":"route", "id":"route:JDR:M14"}, {"type":"route", "id":"route:JDR:M1"}] }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.type" should be "line"
        And the field "impact.objects.0.id" should be "line:JDR:M1"
        And the field "impact.objects.1.type" should be "line_section"
        And the field "impact.objects.1.line_section.0.line.id" should be "line:JDR:M1"
        And the field "impact.objects.1.line_section.0.start_point.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.1.line_section.0.end_point.id" should be "stop_area:JDR:SA:BERAU"
        And the field "impact.objects.1.line_section.0.routes.0.type" should be "route"
        And the field "impact.objects.1.line_section.0.routes.0.id" should be "route:JDR:M14"
        And the field "impact.objects.1.line_section.0.routes.1.type" should be "route"
        And the field "impact.objects.1.line_section.0.routes.1.id" should be "route:JDR:M1"

    Scenario: Add an impact in a disruption with one object, line_section with routes and via valid

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | start_publication_date | end_publication_date     | cause_id                             | client_id                            | contributor_id                       |
            | bar       | bye   | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | a750994c-01fe-11e4-b4fb-080027079ff3 | 2014-04-15T23:52:12    | 2014-04-19T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |
            | toto      |       | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 6a826e64-028f-11e4-92d0-090027079ff3 | 2014-04-20T23:52:12    | 2014-04-30T23:55:12      | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I post to "/disruptions/a750994c-01fe-11e4-b4fb-080027079ff3/impacts" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:M1", "type":"line"},{"id":"line:JDR:M1", "type":"line_section","line_section": {"line":{"id":"line:JDR:M1","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:PTVIN", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, "sens":0, "routes":[{"type":"route", "id":"route:JDR:M14"}, {"type":"route", "id":"route:JDR:M1"}], "via":[{"id":"stop_area:JDR:SA:BERAU", "type":"stop_area"}, {"id":"stop_area:JDR:SA:CHVIN", "type":"stop_area"}] }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"},{"begin": "2014-04-29T16:52:00Z","end": "2014-05-22T02:15:00Z"}]}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should exist
        And the field "impact.objects.0.type" should be "line"
        And the field "impact.objects.0.id" should be "line:JDR:M1"
        And the field "impact.objects.1.type" should be "line_section"
        And the field "impact.objects.1.line_section.0.line.id" should be "line:JDR:M1"
        And the field "impact.objects.1.line_section.0.start_point.id" should be "stop_area:JDR:SA:PTVIN"
        And the field "impact.objects.1.line_section.0.end_point.id" should be "stop_area:JDR:SA:BERAU"
        And the field "impact.objects.1.line_section.0.routes.0.type" should be "route"
        And the field "impact.objects.1.line_section.0.routes.0.id" should be "route:JDR:M14"
        And the field "impact.objects.1.line_section.0.routes.1.type" should be "route"
        And the field "impact.objects.1.line_section.0.routes.1.id" should be "route:JDR:M1"
        And the field "impact.objects.1.line_section.0.via" should have a size of 2

    Scenario: Put impact with line_section : delete line_section
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | cause_id                             | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following ptobject in my database:
            | type         | uri                                              | created_at          | id                                         |
            | stop_area    | stop_area:JDR:SA:BASTI                           | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:CHVIN                           | 2014-04-04T23:52:12 | 2ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line_section | line:JDR:M1:7ffab234-3d49-4eea-aa2c-22f8680230b6 | 2014-04-04T23:52:12 | 3ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line         | line:JDR:M1                                      | 2014-04-06T22:52:12 | 4ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M14                                    | 2014-04-06T22:52:12 | 5ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M1_R                                   | 2014-04-06T22:52:12 | 6ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:NATIO                           | 2014-04-04T23:52:12 | 7ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:REUIL                           | 2014-04-04T23:52:12 | 8ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | network      | network:TAD:CanalTP                              | 2014-04-04T23:52:12 | 9ffab232-3d48-4eea-aa2c-22f8680230b6       |



        Given I have the following line_section in my database:
            | id                                    | line_object_id                        | created_at            | updated_at          | start_object_id                      |end_object_id|sens|object_id|
            | 7ffab234-3d49-4eea-aa2c-22f8680230b6  | 4ffab232-3d48-4eea-aa2c-22f8680230b6  | 2014-04-04T23:52:12   | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6 |2ffab232-3d48-4eea-aa2c-22f8680230b6|0|3ffab232-3d48-4eea-aa2c-22f8680230b6|

        Given I have the relation associate_impact_pt_object in my database:
            | pt_object_id                                  | impact_id                            |
            | 3ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |
            | 9ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_route_object in my database:
            | route_object_id                               | line_section_id                      |
            | 5ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 6ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_via_object in my database:
            | stop_area_object_id                           | line_section_id                      |
            | 7ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 8ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the following applicationperiods in my database:
            | created_at          | updated_at          |id                                   | impact_id                            |start_date                           |end_date            |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 |7ffab232-3d47-4eea-aa2c-22f8680230b1 | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |2014-01-20 16:52:00                  |2014-01-30 16:52:00 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:TAD:CanalTP","type": "network"}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"}]}
        """
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 1
        And the field "impact.objects.0.id" should be "network:TAD:CanalTP"
        And the field "impact.objects.0.type" should be "network"

    Scenario: Put impact with line_section : modify line of line_section
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | cause_id                             | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following ptobject in my database:
            | type         | uri                                              | created_at          | id                                         |
            | stop_area    | stop_area:JDR:SA:BASTI                           | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:CHVIN                           | 2014-04-04T23:52:12 | 2ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line_section | line:JDR:M1:7ffab234-3d49-4eea-aa2c-22f8680230b6 | 2014-04-04T23:52:12 | 3ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line         | line:JDR:M1                                      | 2014-04-06T22:52:12 | 4ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M14                                    | 2014-04-06T22:52:12 | 5ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M1_R                                   | 2014-04-06T22:52:12 | 6ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:NATIO                           | 2014-04-04T23:52:12 | 7ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:REUIL                           | 2014-04-04T23:52:12 | 8ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | network      | network:TAD:CanalTP                              | 2014-04-04T23:52:12 | 9ffab232-3d48-4eea-aa2c-22f8680230b6       |



        Given I have the following line_section in my database:
            | id                                    | line_object_id                        | created_at            | updated_at          | start_object_id                      |end_object_id|sens|object_id|
            | 7ffab234-3d49-4eea-aa2c-22f8680230b6  | 4ffab232-3d48-4eea-aa2c-22f8680230b6  | 2014-04-04T23:52:12   | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6 |2ffab232-3d48-4eea-aa2c-22f8680230b6|0|3ffab232-3d48-4eea-aa2c-22f8680230b6|

        Given I have the relation associate_impact_pt_object in my database:
            | pt_object_id                                  | impact_id                            |
            | 3ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |
            | 9ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_route_object in my database:
            | route_object_id                               | line_section_id                      |
            | 5ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 6ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_via_object in my database:
            | stop_area_object_id                           | line_section_id                      |
            | 7ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 8ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the following applicationperiods in my database:
            | created_at          | updated_at          |id                                   | impact_id                            |start_date                           |end_date            |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 |7ffab232-3d47-4eea-aa2c-22f8680230b1 | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |2014-01-20 16:52:00                  |2014-01-30 16:52:00 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id": "network:TAD:CanalTP","type": "network"}, {"id":"line:JDR:TT", "type":"line_section","line_section": {"line":{"id":"line:JDR:TT","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:BASTI", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:CHVIN", "type":"stop_area"}, "sens":0, "routes":[{"type":"route", "id":"route:JDR:M14"}, {"type":"route", "id":"route:JDR:M1_R"}], "via":[{"id":"stop_area:JDR:SA:NATIO", "type":"stop_area"}, {"id":"stop_area:JDR:SA:REUIL", "type":"stop_area"}] }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"}]}
        """

        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 2
        And the field "impact.objects.0.id" should be "network:TAD:CanalTP"
        And the field "impact.objects.0.type" should be "network"
        And the field "impact.objects.1.id" should be "line:JDR:TT:7ffab232-3d47-4eea-aa2c-22f8680230b6"
        And the field "impact.objects.1.type" should be "line_section"
        And the field "impact.objects.1.line_section.0.line.id" should be "line:JDR:TT"
        And the field "impact.objects.1.line_section.0.line.type" should be "line"
        And the field "impact.objects.1.line_section.0.start_point.type" should be "stop_area"
        And the field "impact.objects.1.line_section.0.start_point.id" should be "stop_area:JDR:SA:BASTI"
        And the field "impact.objects.1.line_section.0.end_point.type" should be "stop_area"
        And the field "impact.objects.1.line_section.0.end_point.id" should be "stop_area:JDR:SA:CHVIN"
        And the field "impact.objects.1.line_section.0.routes" should have a size of 2
        And the field "impact.objects.1.line_section.0.via" should have a size of 2

    Scenario: Put impact with line_section : delete pt_object simple

        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                             |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following contributors in my database:
            | contributor_code   | created_at          | updated_at          | id                                   |
            | contrib1           | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following disruptions in my database:
            | reference | note  | created_at          | updated_at          | status    | id                                   | cause_id                             | client_id                            | contributor_id                       |
            | foo       | hello | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | published | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 | 7ffab555-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
                | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
                | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following impacts in my database:
            | created_at          | updated_at          | status    | id                                   | disruption_id                        |severity_id                          |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | published | 7ffab232-3d47-4eea-aa2c-22f8680230b6 | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab232-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following ptobject in my database:
            | type         | uri                                              | created_at          | id                                         |
            | stop_area    | stop_area:JDR:SA:BASTI                           | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:CHVIN                           | 2014-04-04T23:52:12 | 2ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line_section | line:JDR:M1:7ffab234-3d49-4eea-aa2c-22f8680230b6 | 2014-04-04T23:52:12 | 3ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | line         | line:JDR:M1                                      | 2014-04-06T22:52:12 | 4ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M14                                    | 2014-04-06T22:52:12 | 5ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | route        | route:JDR:M1_R                                   | 2014-04-06T22:52:12 | 6ffab200-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:NATIO                           | 2014-04-04T23:52:12 | 7ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | stop_area    | stop_area:JDR:SA:REUIL                           | 2014-04-04T23:52:12 | 8ffab232-3d48-4eea-aa2c-22f8680230b6       |
            | network      | network:TAD:CanalTP                              | 2014-04-04T23:52:12 | 9ffab232-3d48-4eea-aa2c-22f8680230b6       |



        Given I have the following line_section in my database:
            | id                                    | line_object_id                        | created_at            | updated_at          | start_object_id                      |end_object_id|sens|object_id|
            | 7ffab234-3d49-4eea-aa2c-22f8680230b6  | 4ffab232-3d48-4eea-aa2c-22f8680230b6  | 2014-04-04T23:52:12   | 2014-04-04T23:52:12 | 1ffab232-3d48-4eea-aa2c-22f8680230b6 |2ffab232-3d48-4eea-aa2c-22f8680230b6|0|3ffab232-3d48-4eea-aa2c-22f8680230b6|

        Given I have the relation associate_impact_pt_object in my database:
            | pt_object_id                                  | impact_id                            |
            | 3ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |
            | 9ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_route_object in my database:
            | route_object_id                               | line_section_id                      |
            | 5ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 6ffab200-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the relation associate_line_section_via_object in my database:
            | stop_area_object_id                           | line_section_id                      |
            | 7ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |
            | 8ffab232-3d48-4eea-aa2c-22f8680230b6          | 7ffab234-3d49-4eea-aa2c-22f8680230b6 |

        Given I have the following applicationperiods in my database:
            | created_at          | updated_at          |id                                   | impact_id                            |start_date                           |end_date            |
            | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 |7ffab232-3d47-4eea-aa2c-22f8680230b1 | 7ffab232-3d47-4eea-aa2c-22f8680230b6 |2014-01-20 16:52:00                  |2014-01-30 16:52:00 |

        I fill in header "X-Customer-Id" with "5"
        I fill in header "X-Contributors" with "contrib1"
        I fill in header "X-Coverage" with "jdr"
        I fill in header "Authorization" with "e74598a0-239b-4d9f-92e3-18cfc120672b"
        When I put to "/disruptions/7ffab230-3d48-4eea-aa2c-22f8680230b6/impacts/7ffab232-3d47-4eea-aa2c-22f8680230b6" with:
        """
        {"severity": {"id": "7ffab232-3d48-4eea-aa2c-22f8680230b6"}, "objects": [{"id":"line:JDR:TT", "type":"line_section","line_section": {"line":{"id":"line:JDR:TT","type":"line"}, "start_point":{"id":"stop_area:JDR:SA:BASTI", "type":"stop_area"}, "end_point":{"id":"stop_area:JDR:SA:CHVIN", "type":"stop_area"}, "sens":0, "routes":[{"type":"route", "id":"route:JDR:M14"}, {"type":"route", "id":"route:JDR:M1_R"}], "via":[{"id":"stop_area:JDR:SA:NATIO", "type":"stop_area"}, {"id":"stop_area:JDR:SA:REUIL", "type":"stop_area"}] }}], "application_periods": [{"begin": "2014-04-29T16:52:00Z","end": "2014-06-22T02:15:00Z"}]}
        """

        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "impact.objects" should have a size of 1
        And the field "impact.objects.0.id" should be "line:JDR:TT:7ffab232-3d47-4eea-aa2c-22f8680230b6"
        And the field "impact.objects.0.type" should be "line_section"
        And the field "impact.objects.0.line_section.0.line.id" should be "line:JDR:TT"
        And the field "impact.objects.0.line_section.0.line.type" should be "line"
        And the field "impact.objects.0.line_section.0.start_point.type" should be "stop_area"
        And the field "impact.objects.0.line_section.0.start_point.id" should be "stop_area:JDR:SA:BASTI"
        And the field "impact.objects.0.line_section.0.end_point.type" should be "stop_area"
        And the field "impact.objects.0.line_section.0.end_point.id" should be "stop_area:JDR:SA:CHVIN"
        And the field "impact.objects.0.line_section.0.routes" should have a size of 2
        And the field "impact.objects.0.line_section.0.via" should have a size of 2