

#  Citizen authorises the conveyancer client relationship

  class Citizen_authorises_the_conveyancer_client_relationship

    def initialize()

    end

    def v_init()


        #v_init end
    end

    def v_action()
        @curl = Curl::Easy.new
        @curl.follow_location = true
        @curl.enable_cookies = true

           trans_time = start_traction("I_have_private_citizen_login_credentials")

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

          end_traction("I_have_private_citizen_login_credentials", trans_time)

         trans_time = start_traction("I_login_with_correct_credentials")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["email"] = "citizen@example.org"
             data["post_data"]["password"] = "dummypassword"
             data["post_data"]["submit"] = "Login"
             data["post_data"]["csrf_token"] = "None"
             data["post_data"]["next"] = "/logout"
             response = http_post(@curl, data, "http://172.16.42.43:8007/login")
             assert_http_status(response, 200)

          end_traction("I_login_with_correct_credentials", trans_time)

         genData0 = generic_register_data()

         genData1 = generate_relationship_details("#{genData0["payment"]["titles"][0]}")

         trans_time = start_traction("I_want_to_authorise_my_conveyancer_to_act_on_my_behalf")

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["email"] = "citizen@example.org"
             data["post_data"]["password"] = "dummypassword"
             data["post_data"]["submit"] = "Login"
             data["post_data"]["csrf_token"] = "None"
             data["post_data"]["next"] = "/"
             response = http_post(@curl, data, "http://172.16.42.43:8007/login")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8007/relationship/client")
             assert_http_status(response, 200)

          end_traction("I_want_to_authorise_my_conveyancer_to_act_on_my_behalf", trans_time)

         trans_time = start_traction("I_enter_the_relationship_token_code")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["token"] = genData1["token"]
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/client/accept")
             assert_http_status(response, 200)

          end_traction("I_enter_the_relationship_token_code", trans_time)

         trans_time = start_traction("I_confirm_the_relationship")

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8007"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["agree-execution"] = "on"
             data["post_data"]["token"] = genData1["token"]
             response = http_post(@curl, data, "http://172.16.42.43:8007/relationship/client/confirm")
             assert_http_status(response, 200)

          end_traction("I_confirm_the_relationship", trans_time)

#v_action end
    end

    def v_end()

        #v_end end
    end

  end

    
