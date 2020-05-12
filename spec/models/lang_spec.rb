# frozen_string_literal: true

require 'spec_helper'

module Mokio
  RSpec.describe Lang, type: :model do
    before do
      @lang = Lang.new(
        name: 'Polski',
        shortname: 'pl'
      )
    end

    it 'is valid with a name and a shortname' do
      expect(@lang).to be_valid
    end

    describe 'field validation' do
      it 'is invalid without a name' do
        @lang.name = nil
        @lang.valid?
        expect(@lang.errors[:name]).to(
          include 'Nazwa nie może być pusta'
        )
      end

      it 'is invalid without a shortname' do
        @lang.shortname = nil
        @lang.valid?
        expect(@lang.errors[:shortname]).to(
          include 'Nazwa skrócona nie może być pusta'
        )
      end

      it 'has an unique shortname' do
        @lang.save!
        other_lang = Lang.new(
          name: 'Polski',
          shortname: 'pl'
        )
        other_lang.valid?
        expect(other_lang.errors[:shortname]).to(
          include 'Podana nazwa skrócona jest już zajęta'
        )
      end

      it 'has case insensitive shortname' do
        @lang.save!
        other_lang = Lang.new(
          name: 'Polski 2',
          shortname: 'PL'
        )
        other_lang.valid?
        expect(other_lang.errors[:shortname]).to(
          include 'Podana nazwa skrócona jest już zajęta'
        )
      end

      it "can't be deleted if it's the last lang" do
        @lang.save!
        @lang.destroy
        expect(@lang).to be_present
      end
    end

    context 'when created' do
      it 'creates fake menu' do
        @lang.save!
        fake_menu = Menu.where(name: @lang.shortname)&.first
        expect(fake_menu).to be_present
      end
    end

    context 'when updated' do
      it 'updates dependent menu name' do
        @lang.save!
        new_shortname_for_lang = 'lang shortname'
        @lang.update!(shortname: new_shortname_for_lang)
        dependent_menu = Mokio::Menu.find(@lang.menu_id)
        expect(dependent_menu.name).to eq new_shortname_for_lang
      end
    end

    context 'when deleted' do
      before do
        @lang.save!
        @other_lang = Lang.new(
          name: 'Angielski',
          shortname: 'EN'
        )
        @other_lang.save!
      end

      it 'sets lang_id in all dependent StaticModules to nil' do
        static_module = StaticModule.create!(
          title: 'test module',
          lang_id: @other_lang.id
        )
        @other_lang.destroy!
        updated_module = StaticModule.find(static_module.id)
        expect(updated_module.lang_id).to be_nil
      end

      it 'deletes all dependent ContentLinks' do
        menu = Menu.create!(
          name: 'test menu',
          lang_id: @other_lang.id
        )
        content = Content.create!(title: 'test content')
        content_link = ContentLink.create!(
          menu_id: menu.id,
          content_id: content.id
        )
        @other_lang.destroy!
        deleted_content_link = ContentLink.where(id: content_link.id)
        expect(deleted_content_link).to be_empty
      end

      it 'deletes all dependent Menus' do
        menu = Menu.create!(
          name: 'test menu',
          lang_id: @other_lang.id
        )
        @other_lang.destroy!
        deleted_menu = Menu.where(id: menu.id)
        expect(deleted_menu).to be_empty
      end
    end

    describe 'default language setup' do
      before do
        Mokio.setup do
          Mokio.frontend_default_lang = 'es'
        end
        @default_lang = Lang.new(
          name: 'Hiszpanski',
          shortname: 'es'
        )
        @default_lang.save!
      end

      it 'sets default language based on Mokio config' do
        expect(Lang.default).to eq @default_lang
      end

      it 'sets default language for frontend based on Mokio config' do
        expect(Lang.default_frontend).to eq @default_lang
      end
    end
  end
end
