module OclTools
  module Process
    class Response
      include OclTools::Process::Attributes
      include ActiveModel::Model
      include OclTools::Actions::OptionsField

      def assign_attributes(params = {})
        params.try(:permit!)
        super(params || {})
      end
    end
  end
end
