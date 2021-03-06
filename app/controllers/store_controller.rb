class StoreController < ApplicationController

  def list
     #search the store
    prod = Store.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :location=>p[:address],
        :tel=>p[:tel],
        :lng=>p[:location][:lon],
        :lat=>p[:location][:lat],       
        :description=>p[:description]
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>prods_hash
     }.to_json()
    
  end
  
  def detail
    #parse input
    store_id = params[:id]
    return render :json=> error_500 if store_id.nil?
    
    #find the store
    prod = Store.search :per_page=>1,:page=>1 do
          query do
            match :id, store_id
          end
    end
    return render :json=> error_500 if prod.results.length<1
    store_finded = prod.results.first
    default_resource = select_defaultresource store_finded[:resource] unless store_finded[:resource].nil?
    response_resource = {
            :domain=>PIC_DOMAIN,
            :name=>default_resource[:name].gsub('\\','/'),
            :width=>default_resource[:width],
            :height=>default_resource[:height]
            } unless default_resource.nil?
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
          :id=>store_finded[:id],
          :name=>store_finded[:name],
          :description=>store_finded[:description],
          :englishname=>store_finded[:englishName],
          :createddate =>store_finded[:createdDate],
          :location=> store_finded[:address],
          :tel => store_finded[:tel],
          :lng => store_finded[:location][:lon],
          :lat => store_finded[:location][:lat],
          :gpslat => store_finded[:gpsLat],
          :gpsLng => store_finded[:gpsLng],
          :gpsAlt => store_finded[:gpsAlt],
          :resources=>response_resource
      }
     }
  end
end
