class LibraryController < ApplicationController
  layout false

  def index
  end
  
  
helper_method :getLibOpenArray
helper_method :getFreePCHash
helper_method :getReservedBookResult

require 'net/http'
require 'ostruct'


#get Library api(Details) and return all the Json strings
   def getDetails(address)
    url = URI.parse(address)
    res = Net::HTTP.get(url)
    return res
   end
   
#get Library api(Summary) and return all the Json strings
   def getSummary(address)
    url = URI.parse(address)
    res = Net::HTTP.get(url)
    return res
   end
   
#get Json strings and return parsed hash
    def parse(api)
        obj = JSON.parse(api, object_class: OpenStruct)
        return obj
    end
    
#read parsed hash and return library info as array 
    def getLibOpenArray(key)
        returnArray = []
        obj = parse(getSummary("http://api.lib.sfu.ca/hours/summary"))
          for i in obj
            returnArray.push(i[key])
          end
         return returnArray
    end
    
   
    def getFreePCHash(field, lib_pc)
        obj = parse(getSummary("http://api.lib.sfu.ca/equipment/computers/free_summary"))
        returnArray = []
        returnArray.push(obj[field][lib_pc])
        return returnArray
    end
   
   
    #take user input (search keyword)
    def reserved_book
        course_name = params[:course_name]
        course_number = params[:course_number]
        return course_name, course_number
    end

    # concatenate course name and number to the API url
    def construct_search_URL
        name, number = reserved_book
        url = "http://api.lib.sfu.ca/reserves/search?department=" + name + "&number=" + number
        return url
    end
    
    # with concatenated url, retrieve results
    # return array of Hashes
    def getReservedBookResult
        returnArray = []
        obj = parse(getSummary(construct_search_URL))
        for i in obj["reserves"]
            returnHash = Hash.new
            returnArray.push(returnHash)
            returnHash["Course"] = i["course"]
            returnHash["Instructors"] = i["instructors"]
            returnHash["Title"] = i["title"]
            returnHash["Author"] = i["author"]
            returnHash["Cover_url"] = i["cover_url"]
            returnHash["ISNS"] = i["isns"]
            returnHash["Item_url"] = i["item_url"]
        end
        return returnArray
    end
    
end
