

      def v_init

        #v_init end
      end

      def v_action



        start_traction("I want to create a Register of Title")


                  http_get("http://casework-frontend.landregistry.local/")

                  http_get("http://casework-frontend.landregistry.local/login?next=%2F")

                  http_get("http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css")

                  http_get("http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css")

                  http_get("http://casework-frontend.landregistry.local/static/stylesheets/main.css")

                  http_get("http://casework-frontend.landregistry.local/static/javascript/vendor/jquery-1.11.1.min.js")

                  http_get("http://casework-frontend.landregistry.local/static/images/lr-logo.png")

                  http_post("http://casework-frontend.landregistry.local/login", "email=caseworker%40example.org&password=dummypassword&submit=Login&csrf_token=None&next=%2F")

                  http_get("http://casework-frontend.landregistry.local/")

                  http_get("http://casework-frontend.landregistry.local/registration")


        end_traction("I want to create a Register of Title")



        start_traction("I submit the title details")


                  http_post("http://casework-frontend.landregistry.local/registration", "title_number=TEST1410942923443&full_name1=Quincy+Edwards&full_name2=&address_line_1=9532&address_line_2=Richmond+Terrace+Mews&city=Grange-over-Sands&postcode=EO66+2QU&country=GB&property_tenure=Freehold&property_class=Absolute&price_paid=6244708&extent=%7B%22type%22%3A%22Feature%22%2C%22crs%22%3A%7B%22type%22%3A%22name%22%2C%22properties%22%3A%7B%22name%22%3A%22urn%3Aogc%3Adef%3Acrs%3AEPSG%3A27700%22%7D%7D%2C%22geometry%22%3A%7B%22type%22%3A%22Polygon%22%2C%22coordinates%22%3A%5B%5B%5B404365.03850592196%2C369855.10015086096%5D%2C%5B404626.03850592196%2C369854.10015086096%5D%2C%5B404634.03850592196%2C370077.10015086096%5D%2C%5B404400.03850592196%2C370139.10015086096%5D%2C%5B404365.03850592196%2C369855.10015086096%5D%5D%5D%2C%22properties%22%3A%7B%22Description%22%3A%22Polygon%22%7D%7D%7D")

                  http_get("http://casework-frontend.landregistry.local/registration?created=TEST1410942923443")


        end_traction("I submit the title details")

        #v_action end

      end

      def v_end

        #v_end end
      end
