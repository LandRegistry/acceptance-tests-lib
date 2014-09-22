

#  View Change of Name in work queue

  class View_change_of_name_in_work_queue

    def initialize()

    end

    def v_init()


        #v_init end
    end

    def v_action()
        @curl = Curl::Easy.new
        @curl.follow_location = true
        @curl.enable_cookies = true

           genData0 = generic_register_data()

         genData1 = create_marriage_data("AU", "#{genData0["proprietors"][0]["full_name"]}")

         genData2 = create_change_of_name_marriage_request({"title_number"=>"#{genData0["payment"]["titles"][0]}", "proprietors"=>[{"full_name"=>"#{genData0["proprietors"][0]["full_name"]}"}, {"full_name"=>""}], "property"=>{"address"=>{"address_line_1"=>genData0["property"]["address"]["address_line_1"], "address_line_2"=>"#{genData0["property"]["address"]["address_line_2"]}", "city"=>"#{genData0["property"]["address"]["city"]}", "postcode"=>"#{genData0["property"]["address"]["postcode"]}", "country"=>"#{genData0["property"]["address"]["country"]}"}, "tenure"=>"#{genData0["property"]["tenure"]}", "class_of_title"=>"#{genData0["property"]["class_of_title"]}"}, "payment"=>{"price_paid"=>genData0["payment"]["price_paid"], "titles"=>["#{genData0["payment"]["titles"][0]}"]}, "extent"=>{"type"=>"#{genData0["extent"]["type"]}", "crs"=>{"type"=>"#{genData0["extent"]["crs"]["type"]}", "properties"=>{"#{genData0["extent"]["crs"]["type"]}"=>"#{genData0["extent"]["crs"]["properties"]["#{genData0["extent"]["crs"]["type"]}"]}"}}, "geometry"=>{"type"=>"#{genData0["extent"]["geometry"]["properties"]["Description"]}", "coordinates"=>[[[genData0["extent"]["geometry"]["coordinates"][0][4][0], genData0["extent"]["geometry"]["coordinates"][0][4][1]], [genData0["extent"]["geometry"]["coordinates"][0][1][0], genData0["extent"]["geometry"]["coordinates"][0][1][1]], [genData0["extent"]["geometry"]["coordinates"][0][2][0], genData0["extent"]["geometry"]["coordinates"][0][2][1]], [genData0["extent"]["geometry"]["coordinates"][0][3][0], genData0["extent"]["geometry"]["coordinates"][0][3][1]], [genData0["extent"]["geometry"]["coordinates"][0][4][0], genData0["extent"]["geometry"]["coordinates"][0][4][1]]]], "properties"=>{"Description"=>"#{genData0["extent"]["geometry"]["properties"]["Description"]}"}}}}, {"proprietor_full_name"=>"#{genData0["proprietors"][0]["full_name"]}", "proprietor_new_full_name"=>"#{genData1["proprietor_new_full_name"]}", "partner_name"=>"#{genData1["partner_name"]}", "marriage_date"=>genData1["marriage_date"], "marriage_place"=>"#{genData0["property"]["address"]["city"]}", "marriage_country"=>"#{genData1["marriage_country"]}", "marriage_certificate_number"=>genData1["marriage_certificate_number"]})

         trans_time = start_traction("I_view_the_check_worklist")

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8004/")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/css,*/*;q=0.1"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8004/static/stylesheets/main.css")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8004/static/javascript/vendor/jquery-1.11.1.min.js")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "*/*"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8004/static/images/lr-logo.png")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["Origin"] = "http://172.16.42.43:8004"
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             data["post_data"] = {}
             data["post_data"]["email"] = "caseworker@example.org"
             data["post_data"]["password"] = "dummypassword"
             data["post_data"]["submit"] = "Login"
             data["post_data"]["csrf_token"] = "None"
             data["post_data"]["next"] = "/"
             response = http_post(@curl, data, "http://172.16.42.43:8004/login")
             assert_http_status(response, 200)

             data = {}
             data["header"] = {}
             data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
             data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
             data["header"]["Authorization"] = "Basic Og=="
             response = http_get(@curl, data, "http://172.16.42.43:8004/checks")
             assert_http_status(response, 200)

          end_traction("I_view_the_check_worklist", trans_time)

#v_action end
    end

    def v_end()

        #v_end end
    end

  end

    
