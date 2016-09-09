class CoursesController < ApplicationController
  

  layout 'courses'
  

  before_action :require_user

  
  helper_method :getCourseSearchResult
  helper_method :getCourseDetails
  helper_method :courseSearch

  require 'net/http'
  require 'ostruct'

  def index
  end

	
  
  def show
  end

	def create
	  @user = current_user
    @course = @user.courses.create(course_params)
   
		#@course = current_user.courses.build(course_params)
		if @course.save
			redirect_to '/courses'
		else
			render 'new'
		end
	end

	def destroy
    @user = current_user
    @course = @user.courses.find(params[:id])
    @course.destroy
    redirect_to '/courses'
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
    
#take user input (search keyword)
  def courseSearch
    course_year = params[:course_year]
    course_term = params[:course_term]
    course_name = params[:course_name]
    course_number = params[:course_number]
    course_number = "*"   if params[:course_number].blank?
    return course_year, course_term, course_name, course_number
  end

# concatenate course name and number to the API url
  def construct_search_URL
    year, term, name, number = courseSearch
    url = "http://www.sfu.ca/bin/wcm/course-outlines?" + year + "/" + term + "/" + name + "/" + number
    return url
  end
    
# with concatenated url, retrieve results
# return array of Hashes
  def getCourseSearchResult
    returnArray = []
    obj = parse(getSummary(construct_search_URL))
    for i in obj
      returnHash = Hash.new
      returnArray.push(returnHash)
      returnHash["Title"] = i["title"]
      returnHash["Section"] = i["text"]
    end
    return returnArray
  end
  
  
  ######################## Display Course Details ####################
  ######################### hard coded- might need to refactor code later###
  def courseSearchwithSection()
    course_year = params[:course_year]
    course_term = params[:course_term]
    course_name = params[:course_name]
    course_number = params[:course_number] 
    course_section = params[:course_section]
    return course_year, course_term, course_name, course_number, course_section
  end

# concatenate course name and number to the API url
  def construct_search_URL_withSection
    year, term, name, number, section = courseSearchwithSection
    url = "http://www.sfu.ca/bin/wcm/course-outlines?" + year + "/" + term + "/" + name + "/" + number + "/" + section
    return url
  end
    
# with concatenated url, retrieve results
# return array of Hashes
  def getCourseDetails
    obj = parse(getSummary(construct_search_URL_withSection))
    returnHash = Hash.new
    
    if obj.try(:info)
      returnHash["name"] = obj["info"]["dept"] 
      returnHash["number"] = obj["info"]["number"]
      returnHash["section"] = obj["info"]["section"]
    end
            
    if obj.try(:instructor)
      returnHash["Instructor"] = obj["instructor"][0]["name"] 
      returnHash["Email"] = obj["instructor"][0]["email"]
    else
      returnHash["Instructor"] = "TBA"
    end
        
    if obj.try(:courseSchedule)
      returnHash["Start time"] = obj["courseSchedule"][0]["startTime"]
      returnHash["Room"] = obj["courseSchedule"][0]["roomNumber"]
      returnHash["Days"] = obj["courseSchedule"][0]["days"]
      returnHash["End time"] = obj["courseSchedule"][0]["endTime"]
      returnHash["Lecture type"] = obj["courseSchedule"][0]["sectionCode"]
      returnHash["Building"] = obj["courseSchedule"][0]["buildingCode"]
      returnHash["Campus"] = obj["courseSchedule"][0]["campus"]
    else
      returnHash["courseSchedule"] = "TBA"
    end
        
    if obj.try(:examSchedule)
      returnHash["Exam Start"] = obj["examSchedule"][0]["startTime"]
      returnHash["Exam Date"] = obj["examSchedule"][0]["startDate"]
      returnHash["Exam room"] = obj["examSchedule"][0]["roomNumber"]
      returnHash["Exam End"] = obj["examSchedule"][0]["endTime"]
      returnHash["ExamBuilding"] = obj["examSchedule"][0]["buildingCode"]
      returnHash["ExamCampus"] = obj["examSchedule"][0]["campus"]
    else
      returnHash["examSchedule"] = "TBA"
    end
        
    return returnHash
  end  
  
private
  def course_params
    params.require(:course).permit(:c_name, :c_number, :c_section, :c_time, :c_location, :c_examTime, :c_examLocation)
  end
    
end
