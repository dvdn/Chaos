# Copyright (c) 2001-2014, Canal TP and/or its affiliates. All rights reserved.
#
# This file is part of Navitia,
#     the software to build cool stuff with public transport.
#
# Hope you'll enjoy and contribute to this project,
#     powered by Canal TP (www.canaltp.fr).
# Help us simplify mobility and open public transport:
#     a non ending quest to the responsive locomotion way of traveling!
#
# LICENCE: This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Stay tuned using
# twitter @navitia
# IRC #navitia on freenode
# https://groups.google.com/d/forum/navitia
# www.navitia.io

from flask_restful import fields, url_for
from flask import current_app, request
from  utils import make_pager, get_coverage, get_token
from chaos.navitia import Navitia


class FieldDateTime(fields.Raw):
    def format(self, value):
        if value:
            return value.strftime('%Y-%m-%dT%H:%M:%SZ')
        else:
            return 'null'


class FieldPaginateImpacts(fields.Raw):
    '''
    Pagination of impacts list for one disruption
    '''
    def output(self, key, disruption):
        return make_pager(disruption.impacts.paginate(1, 20),
                          'impact',
                          disruption_id=disruption.id)


class FieldUrlDisruption(fields.Raw):
    def output(self, key, obj):
        return {'href': url_for('disruption',
                                id=obj.disruption_id,
                                _external=True)}


class FieldObjectName(fields.Raw):
    def output(self, key, obj):
        if obj.type == 'line_section':
            return None
        navitia = Navitia(current_app.config['NAVITIA_URL'],
                              get_coverage(request),
                              get_token(request))

        response = navitia.get_pt_object(obj.uri, obj.type)
        if response and 'name' in response:
            return response['name']
        return 'Unable to find object'


class FieldLocalization(fields.Raw):
    def output(self, key, obj):
        retVal = None

        if obj.localization_id:
            navitia = Navitia(current_app.config['NAVITIA_URL'],
                              get_coverage(request),
                              get_token(request))
            response = navitia.get_pt_object(obj.localization_id, 'stop_area')
            if response and 'name' in response:
                retVal = [response]
            else:
                retVal = [
                    {
                        "id": obj.localization_id,
                        "name": "Unable to find object"
                    }
                ]
            retVal[0]["type"] = "stop_area"
        return retVal


class FieldContributor(fields.Raw):
    def output(self, key, obj):
        if hasattr(obj, 'contributor'):
            return obj.contributor.contributor_code
        return None


href_field = {
    "href": fields.String
}

cause_fields = {
    'id': fields.Raw,
    'wording': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'self': {'href': fields.Url('cause', absolute=True)},
}

causes_fields = {
    'causes': fields.List(fields.Nested(cause_fields)),
    'meta': {}
}

one_cause_fields = {
    'cause': fields.Nested(cause_fields)
}

tag_fields = {
    'id': fields.Raw,
    'name': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'self': {'href': fields.Url('tag', absolute=True)},
}

tags_fields = {
    'tags': fields.List(fields.Nested(tag_fields)),
    'meta': {}
}

one_tag_fields = {
    'tag': fields.Nested(tag_fields)
}

disruption_fields = {
    'id': fields.Raw,
    'self': {'href': fields.Url('disruption', absolute=True)},
    'reference': fields.Raw,
    'note': fields.Raw,
    'status': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'publication_period': {
        'begin': FieldDateTime(attribute='start_publication_date'),
        'end': FieldDateTime(attribute='end_publication_date')
    },
    'publication_status': fields.Raw,
    'contributor': FieldContributor,
    'impacts': FieldPaginateImpacts(attribute='impacts'),
    'localization': FieldLocalization,
    'cause': fields.Nested(cause_fields, allow_null=True),
    'tags': fields.List(fields.Nested(tag_fields)),
}

paginate_fields = {
    "start_page": fields.String,
    "items_on_page": fields.String,
    "items_per_page": fields.String,
    "total_result": fields.String,
    "prev": fields.Nested(href_field),
    "next": fields.Nested(href_field),
    "first": fields.Nested(href_field),
    "last": fields.Nested(href_field)
}

meta_fields = {
    "pagination": fields.Nested(paginate_fields)
}

disruptions_fields = {
    "meta": fields.Nested(meta_fields),
    "disruptions": fields.List(fields.Nested(disruption_fields))
}

one_disruption_fields = {
    'disruption': fields.Nested(disruption_fields)
}

error_fields = {
    'error': fields.Nested({'message': fields.String})
}


severity_fields = {
    'id': fields.Raw,
    'wording': fields.Raw,
    'color': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'self': {'href': fields.Url('severity', absolute=True)},
    'priority': fields.Integer(default=None),
    'effect': fields.Raw(),
}

severities_fields = {
    'severities': fields.List(fields.Nested(severity_fields)),
    'meta': {},
}

one_severity_fields = {
    'severity': fields.Nested(severity_fields)
}

one_objectTC_fields = {
    'id': fields.Raw(attribute='uri'),
    'type': fields.Raw,
    'name': FieldObjectName()
}

line_section_fields = {
    'line' : fields.Nested(one_objectTC_fields, display_null=False),
    'start_point': fields.Nested(one_objectTC_fields, display_null=False),
    'end_point': fields.Nested(one_objectTC_fields, display_null=False),
    'sens':fields.Integer(default=None),
    'routes':fields.List(fields.Nested(one_objectTC_fields, display_null=False), display_empty=False),
    'via':fields.List(fields.Nested(one_objectTC_fields, display_null=False), display_empty=False)
}

objectTC_fields = {
    'id': fields.Raw(attribute='uri'),
    'type': fields.Raw,
    'name': FieldObjectName(),
    'line_section': fields.List(fields.Nested(line_section_fields, display_null=False), display_empty=False)
}

channel_fields = {
    'id': fields.Raw,
    'name': fields.Raw,
    'max_size': fields.Integer(default=None),
    'content_type': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'self': {'href': fields.Url('channel', absolute=True)}
}

channels_fields = {
    'channels': fields.List(fields.Nested(channel_fields)),
    'meta': {}
}


one_channel_fields = {
    'channel': fields.Nested(channel_fields)
}

message_fields = {
    'text': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'channel': fields.Nested(channel_fields)
}

application_period_fields = {
    'begin': FieldDateTime(attribute='start_date'),
    'end': FieldDateTime(attribute='end_date')
}

impact_fields = {
    'id': fields.Raw,
    'created_at': FieldDateTime,
    'updated_at': FieldDateTime,
    'objects': fields.List(fields.Nested(objectTC_fields, display_null=False)),
    'application_periods':
        fields.List(fields.Nested(application_period_fields)),
    'severity': fields.Nested(severity_fields),
    'self': {'href': fields.Url('impact', absolute=True)},
    'disruption': FieldUrlDisruption(),
    'messages': fields.List(fields.Nested(message_fields))
}

one_impact_fields = {
    'impact': fields.Nested(impact_fields)
}

impacts_fields = {
    'meta': fields.Nested(meta_fields),
    'impacts': fields.List(fields.Nested(impact_fields))
}

impact_by_object_fields = {
    'id': fields.Raw,
    'type': fields.Raw,
    'name': fields.Raw,
    'impacts': fields.List(fields.Nested(impact_fields))
}

impacts_by_object_fields = {
    'objects': fields.List(fields.Nested(impact_by_object_fields))
}
