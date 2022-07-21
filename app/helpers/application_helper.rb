# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  FLASH_CLASSES = {
    notice: 'alert alert-success',
    success: 'alert alert-success',
    error: 'alert alert-danger',
    alert: 'alert alert-danger'
  }.freeze

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def flash_class(level)
    FLASH_CLASSES[level.to_sym]
  end

  def invalid_input_attribute_class_for(attribute, model:)
    return '' if model.errors.exclude?(attribute)

    'is_invalid'
  end

  def invalid_label_attribute_class_for(attribute, model:)
    return '' if model.errors.exclude?(attribute)

    'invalid-feedback'
  end
end
