module Admin
  class InterviewsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions.
    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def create
      resource = resource_class.new(resource_params)
      if resource.save
        render :crop, locals: { resource: resource, namespace: namespace }
      else
        render :new, locals: { page: Administrate::Page::Form.new(dashboard, resource) }
      end
    end

    def update
      if requested_resource.update(resource_params)
        if resource_params[:image].present?
          render :crop, locals: { resource: requested_resource, namespace: namespace }
        else
          process_cropping(requested_resource)

          redirect_to(
            [namespace, requested_resource],
            notice: translate_with_resource('update.success')
          )
        end
      else
        render :edit, locals: { page: Administrate::Page::Form.new(dashboard, requested_resource) }
      end
    end

    private

    def permitted_attributes
      # make sure croppng attrs available in resource_params (w/o including them into dashboard)
      dashboard.permitted_attributes + [:crop_x, :crop_y, :crop_w, :crop_h]
    end

    def process_cropping(resource)
      return unless resource_params[:crop_x]

      store = resource.image_attacher.store
      crop_params = resource_params.values_at(:crop_w, :crop_h, :crop_x, :crop_y)
      store.crop_image(resource, crop_params)
    end
  end
end
