namespace :osm do
  desc "Get parks in Sydney from Open Street Maps Overpass api"
  task :get_parks => :environment do
    require 'overpass_api_ruby'
    overpass_query = '<osm-script><query into="" type="node"><has-kv k="leisure" modv="" v="park"/><bbox-query e="151.34490966796875" into="" n="-33.57286598605698" s="-34.114647030728655" w="150.5889129638672"/></query><print e="" from="" geometry="skeleton" limit="" mode="body" n="" order="id" s="" w=""/></osm-script>'
    overpass = OverpassAPI.new
    parks = overpass.query(overpass_query)

    current_park_count = Park.count

    parks.each do |park|
      Park.where(osm_id: park[:id]).first_or_initialize.update!(
        name: park[:tags]["name"],
        osm_id: park[:id],
        latitude: park[:lat],
        longitude: park[:lon]
      )
    end

    p "Added #{Park.count - current_park_count} new parks"
  end
end
