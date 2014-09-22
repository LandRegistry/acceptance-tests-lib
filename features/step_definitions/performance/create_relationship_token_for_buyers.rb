

#  Create relationship token for buyers

  class Create_relationship_token_for_buyers

    def initialize()

    end

    def v_init()


        #v_init end
    end

    def v_action()
        @curl = Curl::Easy.new
        @curl.follow_location = true
        @curl.enable_cookies = true

           trans_time = start_traction("I_am_not_already_logged_in_as_a_conveyancer")

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/logout")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/govuk-template.css?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/fonts.css?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/landregistry-main.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/javascripts/vendor/jquery-1.11.1.min.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/javascripts/govuk-template.js?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/images/gov.uk_logotype_crown.png?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/images/open-government-licence.png?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/images/govuk-crest.png?0.8.1")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/stylesheets/govuk-template-print.css?0.8.1")
             assert_http_status(response, 200)

          end_traction("I_am_not_already_logged_in_as_a_conveyancer", trans_time)

         genData0 = generate_client_details()

         genData1 = generic_register_data()

         trans_time = start_traction("I_request_to_create_a_client_relationship")

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/search")
             assert_http_status(response, 200)

          end_traction("I_request_to_create_a_client_relationship", trans_time)

         trans_time = start_traction("I_login_with_correct_credentials")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["email"] = "conveyancer@example.org"
             data["post_data"]["password"] = "dummypassword"
             data["post_data"]["submit"] = "Login"
             data["post_data"]["csrf_token"] = "None"
             data["post_data"]["next"] = "/relationship/conveyancer/search"
             response = http_post(@curl, data, "http://172.16.42.43:8007/login")
             assert_http_status(response, 200)

          end_traction("I_login_with_correct_credentials", trans_time)

         trans_time = start_traction("I_select_the_property")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["search-text"] = genData1["title_number"]
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/property")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build/javascripts/vendor/leaflet-0.7.3/leaflet.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build//javascripts/proj4.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build//javascripts/proj4leaflet.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build//javascripts/osopenspace.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/static/build//javascripts/map.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,369500,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404000,369000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://openspace.ordnancesurvey.co.uk/osmapapi/ts?KEY=FFB702322FDF714DE0430B6CA40A06C6&URL=file%3A%2F%2F%2F&SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.1&FORMAT=image%2Fpng&height=200&width=200&debug=true&srs=EPSG%3A27700&BBOX=404500,369000,0,0&WIDTH=200&HEIGHT=200&LAYERS=2.5")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["title_no"] = genData1["title_number"]
             data["post_data"]["house_number"] = genData1["proprietors"][1]["full_name"]
             data["post_data"]["road"] = genData1["proprietors"][1]["full_name"]
             data["post_data"]["town"] = genData1["proprietors"][1]["full_name"]
             data["post_data"]["postalCode"] = genData1["property"]["address"]["postcode"]
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/task")
             assert_http_status(response, 200)

          end_traction("I_select_the_property", trans_time)

         trans_time = start_traction("The_clients_want_to_buy_the_property")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["buying_or_selling_property"] = "buying"
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/client")
             assert_http_status(response, 200)

          end_traction("The_clients_want_to_buy_the_property", trans_time)

         trans_time = start_traction("I_enter_the_clients_details")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["csrf_token"] = "None"
             data["post_data"]["full_name"] = genData0["clients"]["full_name"]
             data["post_data"]["date_of_birth"] = genData0["clients"]["date_of_birth"]
             data["post_data"]["address"] = genData0["clients"]["address"]
             data["post_data"]["telephone"] = genData0["clients"]["telephone"]
             data["post_data"]["email"] = genData0["clients"]["email"]
             data["post_data"]["gender"] = genData0["clients"]["gender"]
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/confirm")
             assert_http_status(response, 200)

          end_traction("I_enter_the_clients_details", trans_time)

         trans_time = start_traction("I_confirm_the_details_entered")

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/relationship/conveyancer/token")
             assert_http_status(response, 200)

          end_traction("I_confirm_the_details_entered", trans_time)

#v_action end
    end

    def v_end()

        #v_end end
    end

  end

    
