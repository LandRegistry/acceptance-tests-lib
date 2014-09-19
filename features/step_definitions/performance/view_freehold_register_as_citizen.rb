

  class View_freehold_register_as_citizen

      def initialize()

      end

      def v_init()


          #v_init end
      end

      def v_action()
          @curl = Curl::Easy.new
          @curl.follow_location = true
          @curl.enable_cookies = true

          trans_time = start_traction("I_view_the_property_details_on_gov.uk")
             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk//property/TEST355537789")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build//javascripts/proj4.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build//javascripts/proj4leaflet.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build//javascripts/osopenspace.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/govuk-template.css?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/fonts.css?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/landregistry-main.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build//javascripts/map.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/javascripts/govuk-template.js?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/images/gov.uk_logotype_crown.png?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/govuk-template-print.css?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=403500,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=405000,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=403500,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=405000,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/images/open-government-licence.png?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic bGFuZHJlZ2lzdHJ5Om5vdHRvYmVzaGFyZWRv"
             response = http_get(@curl, data, "http://www.gov.uk.landregistryconcept.co.uk/static/build/stylesheets/images/govuk-crest.png?0.8.1")
             assert_http_status(response, 200)

          end_traction("I_view_the_property_details_on_gov.uk", trans_time)

#v_action end
      end

      def v_end()

          #v_end end
      end

  end
