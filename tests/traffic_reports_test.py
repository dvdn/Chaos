from nose.tools import *
from chaos.utils import get_traffic_report_objects, get_pt_object_from_list
import chaos
from mock import MagicMock


class Obj(object):
    pass


def test_get_traffic_report_objects():
    dd = get_traffic_report_objects([], Obj())
    eq_(len(dd["traffic_report"].items()), 0)


def test_get_traffic_report_without_objects():
    impact = chaos.models.Impact()
    dd = get_traffic_report_objects([impact], Obj())
    eq_(len(dd["traffic_report"].items()), 0)


def test_get_pt_object_from_list_None():
    stop_area = chaos.models.PTobject()
    stop_area.type = 'stop_area'
    stop_area.uri = 'uri1'
    eq_(get_pt_object_from_list(stop_area, []), None)


def test_get_pt_object_from_list_True():
    stop_area = chaos.models.PTobject()
    stop_area.type = 'stop_area'
    stop_area.uri = 'uri1'
    eq_(get_pt_object_from_list(stop_area, [{'id': 'uri1', 'name': 'stop area name'}]),
        {'id': 'uri1', 'name': 'stop area name'})


def test_get_pt_object_from_list_True_2_objects():
    stop_area = chaos.models.PTobject()
    stop_area.type = 'stop_area'
    stop_area.uri = 'uri1'
    eq_(get_pt_object_from_list(stop_area, [{'id': 'uri2', 'name': 'stop area name'},
                                            {'id': 'uri1', 'name': 'stop area name'}]),
        {'id': 'uri1', 'name': 'stop area name'})


def test_get_traffic_report_with_network():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = MagicMock(return_value={"id": "uri1", "name": "network name"})
    network = chaos.models.PTobject()
    network.type = 'network'
    network.uri = 'uri1'
    impact = chaos.models.Impact()
    impact.objects.append(network)
    result = {
        "uri1": {
            "network": {
                "id": "uri1",
                "name": "network name",
                "impacts": [impact]
            }
        }
    }
    dd = get_traffic_report_objects([impact], navitia)
    eq_(cmp(dd["traffic_report"], result), 0)


def get_pt_object(uri, object_type, pt_objects=None):

    if uri == 'network:uri1' and not pt_objects:
        return {'id': 'network:uri1', 'name': 'network 1 name'}

    if uri == 'network:uri2' and not pt_objects:
        return {'id': 'network:uri2', 'name': 'network 2 name'}

    if uri == 'line:uri1' and pt_objects:
        return [{'id': 'network:uri1', 'name': 'network 1 name'}]

    if uri == 'line:uri2' and not pt_objects:
        return {'id': 'line:uri2', 'name': 'line 2 name'}

    if uri == 'stop_area:uri1' and not pt_objects:
        return {'id': 'stop_area:uri1', 'name': 'stop area 1 name'}

    if uri == 'stop_area:uri1' and pt_objects:
        return [{'id': 'network:uri3', 'name': 'network 3 name'}]

    if uri == 'line:uri1' and not pt_objects:
        return {'id': 'line:uri1', 'name': 'line 1 name'}

    if uri == 'line:uri2' and pt_objects:
        return [{'id': 'network:uri2', 'name': 'network 2 name'}]

    if uri == 'stop_area:uri2' and not pt_objects:
        return {'id': 'stop_area:uri2', 'name': 'stop area 2 name'}

    if uri == 'stop_area:uri2' and pt_objects:
        return [{'id': 'network:uri4', 'name': 'network 4 name'}, {'id': 'network:uri5', 'name': 'network 5 name'}]


def test_get_traffic_report_with_impact_on_lines():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = get_pt_object
    impact = chaos.models.Impact()

    line = chaos.models.PTobject()
    line.type = 'line'
    line.uri = 'line:uri1'
    impact.objects.append(line)

    line = chaos.models.PTobject()
    line.type = 'line'
    line.uri = 'line:uri2'
    impact.objects.append(line)

    result = {
        "network:uri1": {
            "network": {
                "id": "network:uri1",
                "name": "network 1 name"
            },
            "lines": [{'id': 'line:uri1', 'name': 'line 1 name', "impacts": [impact]}]
        },
        "network:uri2": {
            "network": {
                "id": "network:uri2",
                "name": "network 2 name"
            },
            "lines": [{'id': 'line:uri2', 'name': 'line 2 name', "impacts": [impact]}]
        }
    }
    dd = get_traffic_report_objects([impact], navitia)
    eq_(cmp(dd["traffic_report"], result), 0)


def test_get_traffic_report_with_impact_on_networks():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = get_pt_object
    impact = chaos.models.Impact()

    line = chaos.models.PTobject()
    line.type = 'network'
    line.uri = 'network:uri1'
    impact.objects.append(line)

    line = chaos.models.PTobject()
    line.type = 'network'
    line.uri = 'network:uri2'
    impact.objects.append(line)

    result = {
        "network:uri1": {
            "network": {
                "id": "network:uri1",
                "name": "network 1 name",
                "impacts": [impact]
            }
        },
        "network:uri2": {
            "network": {
                "id": "network:uri2",
                "name": "network 2 name",
                "impacts": [impact]
            }
        }
    }
    dd = get_traffic_report_objects([impact], navitia)

    eq_(cmp(dd["traffic_report"], result), 0)


def test_get_traffic_report_with_impact_on_stop_areas_one_network():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = get_pt_object
    impact = chaos.models.Impact()

    line = chaos.models.PTobject()
    line.type = 'stop_area'
    line.uri = 'stop_area:uri1'
    impact.objects.append(line)

    result = {
        "network:uri3": {
            "network": {
                "id": "network:uri3",
                "name": "network 3 name"
            },
            "stop_areas": [{'id': 'stop_area:uri1', 'name': 'stop area 1 name', "impacts": [impact]}]
        }
    }
    dd = get_traffic_report_objects([impact], navitia)
    eq_(cmp(dd["traffic_report"], result), 0)


def test_get_traffic_report_with_impact_on_stop_areas_2_networks():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = get_pt_object
    impact = chaos.models.Impact()

    line = chaos.models.PTobject()
    line.type = 'stop_area'
    line.uri = 'stop_area:uri2'
    impact.objects.append(line)

    result = {
        "network:uri4": {
            "network": {
                "id": "network:uri4",
                "name": "network 4 name"
            },
            "stop_areas": [{'id': 'stop_area:uri2', 'name': 'stop area 2 name', "impacts": [impact]}]
        },
        "network:uri5": {
            "network": {
                "id": "network:uri5",
                "name": "network 5 name"
            },
            "stop_areas": [{'id': 'stop_area:uri2', 'name': 'stop area 2 name', "impacts": [impact]}]
        }
    }
    dd = get_traffic_report_objects([impact], navitia)
    eq_(cmp(dd["traffic_report"], result), 0)


def test_get_traffic_report_with_2_impact_on_stop_area():
    navitia = chaos.navitia.Navitia('http://api.navitia.io', 'jdr')
    navitia.get_pt_object = get_pt_object
    impacts = []

    impact = chaos.models.Impact()
    stop_area = chaos.models.PTobject()
    stop_area.type = 'stop_area'
    stop_area.uri = 'stop_area:uri1'
    impact.objects.append(stop_area)

    impacts.append(impact)
    impact = chaos.models.Impact()
    stop_area = chaos.models.PTobject()
    stop_area.type = 'stop_area'
    stop_area.uri = 'stop_area:uri1'
    impact.objects.append(stop_area)
    impacts.append(impact)

    result = {
        "network:uri3": {
            "network": {
                "id": "network:uri3",
                "name": "network 3 name"
            },
            "stop_areas": [{'id': 'stop_area:uri1', 'name': 'stop area 1 name', "impacts": impacts}]
        }
    }
    dd = get_traffic_report_objects(impacts, navitia)
    eq_(cmp(dd["traffic_report"], result), 0)
