

        class Processing_absolute_freehold_first_registration_with_1_proprietor_3

          def initialize()

          end

          def v_init()


            #v_init end
          end

          def v_action()
@curl = Curl::Easy.new
@curl.follow_location = true
@curl.enable_cookies = true
            

        trans_time = start_traction("I_want_to_create_a_register_of_title")
        
                  data = {}
                
        data["header"] = {}
      
              data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
            
              data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
            
              data["header"]["Authorization"] = "Basic Og=="
            
          response = http_get(@curl, data, "http://172.16.42.43:8004/")
        
                  data = {}
                
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
            
          response = http_post(@curl, data, "http://172.16.42.43:8004/login", "email=caseworker%40example.org&password=dummypassword&submit=Login&csrf_token=None&next=%2F")
        
                  data = {}
                
  assert_http_status(response, 200)
  
                  data = {}
                
        data["header"] = {}
      
              data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
            
              data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
            
              data["header"]["Authorization"] = "Basic Og=="
            
          response = http_get(@curl, data, "http://172.16.42.43:8004/registration")
        
  assert_http_status(response, 200)
  
        end_traction("I_want_to_create_a_register_of_title", trans_time)

        

        trans_time = start_traction("I_submit_the_title_details")
        
                  data = {}
                
        data["header"] = {}
      
              data["header"]["Origin"] = "http://172.16.42.43:8004"
            
              data["header"]["User-Agent"] = "Mozilla/5.0 (Macintosh; PPC Mac OS X) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34"
            
              data["header"]["Content-Type"] = "application/x-www-form-urlencoded"
            
              data["header"]["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
            
              data["header"]["Authorization"] = "Basic Og=="
            
          response = http_post(@curl, data, "http://172.16.42.43:8004/registration", "title_number=TEST1411040396626&full_name1=Sam+Thompson&full_name2=&address_line_1=4297&address_line_2=Palace+Gardens+Terrace&city=East+Retford&postcode=Y2B+1JR&country=GB&property_tenure=Freehold&property_class=Absolute&price_paid=3042635&extent=%7B%22type%22%3A%22Feature%22%2C%22crs%22%3A%7B%22type%22%3A%22name%22%2C%22properties%22%3A%7B%22name%22%3A%22urn%3Aogc%3Adef%3Acrs%3AEPSG%3A27700%22%7D%7D%2C%22geometry%22%3A%7B%22type%22%3A%22Polygon%22%2C%22coordinates%22%3A%5B%5B%5B404375.4307233664%2C369847.02267609315%5D%2C%5B404632.4307233664%2C369827.02267609315%5D%2C%5B404647.4307233664%2C370137.02267609315%5D%2C%5B404428.4307233664%2C370080.02267609315%5D%2C%5B404375.4307233664%2C369847.02267609315%5D%5D%5D%2C%22properties%22%3A%7B%22Description%22%3A%22Polygon%22%7D%7D%7D")
        
                  data = {}
                
  assert_http_status(response, 200)
  
        end_traction("I_submit_the_title_details", trans_time)

        #v_action end
    
  
            
    
        
        
        
        
        
  
            
    
    
  
    
        
        
        
  
            
  
            
    
        
        
        
        
        
  
            
  
    
        
        
        
  
            
  
    
        
        
        
  
            
  
    
        
        
        
  
            
  
    
        
        
        
  
            
  
    
        
        
        
  
            
  
            
    
        
        
        
  
            
    
          end

          def v_end()

            #v_end end
          end

        end

      
