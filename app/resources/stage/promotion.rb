module Stage
  class Promotion < Stage::Base
    self.collection_name = :promotion

    class << self
      def list(options = {})
        default_options = { page: 1, pagesize: 10, sort: 1, client_version: '2.3' }
        options = default_options.merge(options.delete_if {|k, v| v.blank?})

        raw_data = get(:list, options)['data']

        promotions = raw_data['promotions'].inject([]) do |_r, _p|
          _r << self.new(_p)
          _r
        end

        Kaminari.paginate_array(
          promotions,
          total_count: raw_data['totalcount'].to_i
        ).page(raw_data['pageindex']).per(raw_data['pagesize'])
      end

    end

    def image_url
      return '' if resources.blank?

      [PIC_DOMAIN, resources[0].name, "_320X0.jpg"].join('')
    end
  end
end
