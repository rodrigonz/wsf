#!/usr/bin/env ruby

# Copyright 2005,2008 WSO2, Inc. http://wso2.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'wsf'

include WSO2::WSF

def print_hash(hash)
  hash.each_pair {|key, value|
         if value.kind_of? Hash
           puts "_#{key}_"
           print_hash(value)
         else
           puts "#{key}, #{value}\n" 
         end 
       }
  end

begin
  LOG_FILE_NAME = "ruby_echo_client.log" 
  END_POINT = "C:/sample_wsdl_20.wsdl"

  client = WSClient.new({"wsdl" => END_POINT}, LOG_FILE_NAME)
  
  proxy = client.get_proxy
  
  unless proxy.nil?
    ret = proxy.GetPrice({"GetPriceRequest"=> {"ProductType"=> "Testing",
                                                                           "ItemNo" => 234}});   
    
    if not ret.nil? then
      puts "Received Hash : " << "\n" 
      
      print_hash(ret) 
              
      puts "Client invocation SUCCESSFUL !!!"
    else
      puts "Client invocation FAILED !!!"
    end
  else
    puts "Proxy is nill, could not proceed"
  end
  
rescue WSFault => wsfault
  puts "Client invocation FAILED !!!\n"
  puts "WSFault : "
  puts wsfault.xml
  puts "----------"
  puts wsfault.code
  puts "----------"
  puts wsfault.reason
  puts "----------"
  puts wsfault.role
  puts "----------"
  puts wsfault.detail
  puts "----------"
end
