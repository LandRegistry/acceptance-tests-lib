

        class Processing_absolute_freehold_first_registration_with_1_proprietor_3

          def initialize()
            @curl = ''
          end

          def v_init()

            #v_init end
          end

          def v_action()



        trans_time = start_traction("I_want_to_create_a_register_of_title")

                  http_get("http://172.16.42.43:8004/")

                  http_get("http://172.16.42.43:8004/login?next=%2F")

                  http_get("http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css")

                  http_get("http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css")

                  http_get("http://172.16.42.43:8004/static/stylesheets/main.css")

                  http_get("http://172.16.42.43:8004/static/javascript/vendor/jquery-1.11.1.min.js")

                  http_get("http://172.16.42.43:8004/static/images/lr-logo.png")

                  http_post("http://172.16.42.43:8004/login", "email=caseworker%40example.org&password=dummypassword&submit=Login&csrf_token=None&next=%2F")

                  http_get("http://172.16.42.43:8004/")

                  http_get("http://172.16.42.43:8004/registration")

        end_traction("I_want_to_create_a_register_of_title", trans_time)



        trans_time = start_traction("I_submit_the_title_details")

                  http_post("http://172.16.42.43:8004/registration", "title_number=TEST1410948276507&full_name1=Diane+Pease&full_name2=&address_line_1=6171&address_line_2=Quick+Street&city=Yate&postcode=EO66+2QU&country=GB&property_tenure=Freehold&property_class=Absolute&price_paid=1287483&extent=%7B%22type%22%3A%22Feature%22%2C%22crs%22%3A%7B%22type%22%3A%22name%22%2C%22properties%22%3A%7B%22name%22%3A%22urn%3Aogc%3Adef%3Acrs%3AEPSG%3A27700%22%7D%7D%2C%22geometry%22%3A%7B%22type%22%3A%22Polygon%22%2C%22coordinates%22%3A%5B%5B%5B404394.84864973463%2C369862.38913673995%5D%2C%5B404661.84864973463%2C369834.38913673995%5D%2C%5B404638.84864973463%2C370096.38913673995%5D%2C%5B404361.84864973463%2C370118.38913673995%5D%2C%5B404394.84864973463%2C369862.38913673995%5D%5D%5D%2C%22properties%22%3A%7B%22Description%22%3A%22Polygon%22%7D%7D%7D")

                  http_get("http://172.16.42.43:8004/registration?created=TEST1410948276507")

        end_traction("I_submit_the_title_details", trans_time)

        #v_action end
















          end

          def v_end()

            #v_end end
          end

        end
