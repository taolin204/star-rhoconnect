require 'json'
require 'rest_client'

class Company < SourceAdapter
  def initialize(source)
    @base = 'http://192.168.2.22:3000' 
    super(source)
  end
 
  def login
    # TODO: Login to your data source here if necessary
    @token = Store.get_value("username:#{current_user.login}:token")
    puts "token loaded for #{current_user.login}, token: #{@token}"
  end
 
  def query(params=nil)
    # TODO: Query your backend data source and assign the records 
    # to a nested hash structure called @result. For example:
    # @result = { 
    #   "1"=>{"name"=>"Acme", "industry"=>"Electronics"},
    #   "2"=>{"name"=>"Best", "industry"=>"Software"}
    # }
    puts "calling query #{@base}/companies.json?auth_token=#{@token}"
    rest_result = RestClient.get("#{@base}/companies.json?auth_token=#{@token}").body
    if rest_result.code != 200
      raise SourceAdapterException.new("Error connecting!")
    end
    parsed = JSON.parse(rest_result)
    puts "query results: #{parsed}"

    @result={}
    parsed.each do |item|
      @result[item["company"]["id"].to_s] = item["company"]
    end if parsed
    # return @result
    # raise SourceAdapterException.new("Please provide some code to read records from the backend data source")
  end
 
  def sync
    # Manipulate @result before it is saved, or save it 
    # yourself using the Rhoconnect::Store interface.
    # By default, super is called below which simply saves @result
    # TL- Disable 'super', copy the code from query.
    super

  end
 
  def create(create_hash)
    # TODO: Create a new record in your backend data source
    puts "calling create #{@base}/companies?auth_token=#{@token}"
    res = RestClient.post("#{@base}/companies?auth_token=#{@token}",{:company => create_hash, :content_type => :json, :accept => :json})
    puts "create results: #{res}"
    # raise "Please provide some code to create a single record in the backend data source using the create_hash"
    # After create we are redirected to the new record.
    # We need to get the id of that record and return
    # it as part of create so rhosync can establish a link
    # from its temporary object on the client to this newly
    # created object on the server
    JSON.parse( res.body )["id"]
  end
 
  def update(update_hash)
    # TODO: Update an existing record in your backend data source
    obj_id = update_hash['id']
    update_hash.delete('id')
    puts "calling update #{@base}/companies/#{obj_id}?auth_token=#{@token}"
    res = RestClient.put("#{@base}/companies/#{obj_id}?auth_token=#{@token}", {:company => update_hash, :content_type => :json, :accept => :json})
    puts "update results: #{res}"
    # raise "Please provide some code to update a single record in the backend data source using the update_hash"
  end
 
  def delete(delete_hash)
    # TODO: write some code here if applicable
    # be sure to have a hash key and value for "object"
    # for now, we'll say that its OK to not have a delete operation
    # raise "Please provide some code to delete a single object in the backend application using the object_id"
    if delete_hash['id']
      puts "calling delete"
      puts "Calling destroy on #{@base}/companies/#{delete_hash['id']}?auth_token=#{@token}"
      res = RestClient.delete("#{@base}/companies/#{delete_hash['id']}?auth_token=#{@token}")
    else
      puts "no delete_hash['id']"
    end
  end
 
  def logoff
    # TODO: Logout from the data source if necessary
  end
end