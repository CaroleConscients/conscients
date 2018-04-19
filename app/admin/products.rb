# frozen_string_literal: true

ActiveAdmin.register Product do
  menu parent: I18n.t('i18n.product_management')
  config.sort_order = 'position_asc'

  permit_params :name_fr, :name_en, :description, :description_en, :ht_price_cents, :position,
                :tax_rate, :weight, :product_type, :published, :ht_buying_price_cents,
                :seo_title, :seo_title_en, :meta_description, :meta_description_en,
                :keywords, :keywords_en, :slug, :slug_en, :producer_latitude,
                :producer_longitude

  includes :text_translations

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :name_fr
    column :name_en
    column :slug_fr
    column :slug_en
    column :description_fr
    column :description_en
    column :published
    column :position
    column :ht_price_cents
    column :ht_buying_price_cents
    column :tax_rate
    column :weight
    column :product_type
    column :seo_title_fr
    column :seo_title_en
    column :meta_description_fr
    column :meta_description_en
    column :keywords_fr
    column :keywords_en
    column :producer_latitude
    column :producer_longitude
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :name_fr
      f.input :name_en
      f.input :slug_fr
      f.input :slug_en
      f.input :description_fr
      f.input :description_en
      f.input :published
      f.input :position
      f.input :ht_price_cents
      f.input :ht_buying_price_cents
      f.input :tax_rate
      f.input :weight
      f.input :product_type
      f.input :seo_title_fr
      f.input :seo_title_en
      f.input :meta_description_fr
      f.input :meta_description_en
      f.input :keywords_fr
      f.input :keywords_en
      f.input :producer_latitude
      f.input :producer_longitude
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name_fr
      row :name_en
      row :slug_fr
      row :slug_en
      row :description_fr
      row :description_en
      row :published
      row :position
      row :ht_price_cents
      row :ht_buying_price_cents
      row :tax_rate
      row :weight
      row :product_type
      row :seo_title_fr
      row :seo_title_en
      row :meta_description_fr
      row :meta_description_en
      row :keywords_fr
      row :keywords_en
      row :producer_latitude
      row :producer_longitude
      row :created_at
      row :updated_at
    end
  end
end
