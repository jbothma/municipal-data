from django.conf.urls import url
from django.views.decorators.cache import cache_page
from django.views.generic.base import TemplateView
from wazimap.views import GeographyDetailView, PlaceSearchJson

# This cache is reset on each deployment. Corresponding caching headers are
# sent to the client, too.
CACHE_SECS = 12 * 60 * 60

urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name='index.html'), name='homepage'),

    # e.g. /profiles/province-GT/
    url(
        regex   = '^profiles/(?P<geography_id>\w+-\w+)(-(?P<slug>[\w-]+))?/$',
        view    = cache_page(CACHE_SECS)(GeographyDetailView.as_view()),
        kwargs  = {},
        name    = 'geography_detail',
    ),
    url(
        regex   = '^place-search/json/$',
        view    = cache_page(CACHE_SECS)(PlaceSearchJson.as_view()),
        kwargs  = {},
        name    = 'place_search_json',
    ),
]
