# frozen_string_literal: true

ActiveAdmin.register TreePlantation do
  menu parent: I18n.t('active_admin.product_management')

  permit_params :project_name, :project_type_fr, :project_type_en, :partner, :plantation_uuid,
                :base_certificate_uuid, :latitude, :longitude, :is_full,
                :tree_specie, :producer_name, :trees_quantity, :klm_file,
                :producer_presentation, :project_presentation

  includes :klm_file_attachment
  includes :producer_presentation_attachment
  includes :project_presentation_attachment

  index do
    selectable_column
    id_column
    column :project_name
    column :project_type_fr
    column :project_type_en
    column :partner
    column :plantation_uuid
    column :base_certificate_uuid
    column :latitude
    column :longitude
    column :tree_specie
    column :producer_name
    column :trees_quantity
    column :klm_file do |tree_plantation|
      I18n.t('active_admin.attachement_uploaded') if tree_plantation.klm_file.attached?
    end
    column :producer_presentation do |tree_plantation|
      I18n.t('active_admin.attachement_uploaded') if tree_plantation.producer_presentation.attached?
    end
    column :project_presentation do |tree_plantation|
      I18n.t('active_admin.attachement_uploaded') if tree_plantation.project_presentation.attached?
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :project_name
      f.input :project_type_fr
      f.input :project_type_en
      f.input :partner
      f.input :plantation_uuid
      f.input :base_certificate_uuid
      f.input :latitude
      f.input :longitude
      f.input :tree_specie
      f.input :producer_name
      f.input :trees_quantity
      f.input :klm_file, as: :file,
        hint: tree_plantation.klm_file.attached? && I18n.t('active_admin.attachement_uploaded')
      f.input :producer_presentation, as: :file,
        hint: tree_plantation.producer_presentation.attached? && I18n.t('active_admin.attachement_uploaded')
      f.input :project_presentation, as: :file,
        hint: tree_plantation.project_presentation.attached? && I18n.t('active_admin.attachement_uploaded')
      if f.object.is_full
        f.input :is_full, as: :boolean, label: simple_format(I18n.t('active_admin.is_full_change'))
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :project_name
      row :project_type_fr
      row :project_type_en
      row :partner
      row :plantation_uuid
      row :base_certificate_uuid
      row :latitude
      row :longitude
      row :tree_specie
      row :producer_name
      row :trees_quantity
      row :klm_file do |tree_plantation|
        I18n.t('active_admin.attachement_uploaded') if tree_plantation.klm_file.attached?
      end
      row :producer_presentation do |tree_plantation|
        I18n.t('active_admin.attachement_uploaded') if tree_plantation.producer_presentation.attached?
      end
      row :project_presentation do |tree_plantation|
        I18n.t('active_admin.attachement_uploaded') if tree_plantation.project_presentation.attached?
      end
      row :created_at
      row :updated_at
    end
  end
end
