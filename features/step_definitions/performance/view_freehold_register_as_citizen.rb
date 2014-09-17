

        class View_freehold_register_as_citizen

          def initialize()
            @curl = ''
          end

          def v_init()

            #v_init end
          end

          def v_action()



        trans_time = start_traction("I_view_the_property_details_on_gov.uk")

                  http_get("http://172.16.42.43:8002/property/TEST147145758")

                  http_get("http://172.16.42.43:8002/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.css")

                  http_get("http://172.16.42.43:8002/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.js")

                  http_get("http://172.16.42.43:8002/static/build//javascripts/proj4.js")

                  http_get("http://172.16.42.43:8002/static/build//javascripts/proj4leaflet.js")

                  http_get("http://172.16.42.43:8002/static/build//javascripts/osopenspace.js")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/govuk-template.css?0.8.1")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/fonts.css?0.8.1")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/landregistry-main.css")

                  http_get("http://172.16.42.43:8002/static/build//javascripts/map.js")

                  http_get("http://172.16.42.43:8002/static/build/javascripts/govuk-template.js?0.8.1")

                  http_get("http://172.16.42.43:8002/static/build/images/gov.uk_logotype_crown.png?0.8.1")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/govuk-template-print.css?0.8.1")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/images/open-government-licence.png?0.8.1")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

              #    http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=403500,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=405000,370000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                #  http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=403500,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                  #http_get("http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=405000,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")

                  http_get("http://172.16.42.43:8002/static/build/stylesheets/images/govuk-crest.png?0.8.1")

        end_traction("I_view_the_property_details_on_gov.uk", trans_time)

        #v_action end



























          end

          def v_end()

            #v_end end
          end

        end
