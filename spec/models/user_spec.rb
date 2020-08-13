# frozen_string_literal: true

require 'spec_helper'

module Mokio
  RSpec.describe User, type: :model do
    before do
      @user = User.new(
        email: 'admin@admin.com',
        password: 'ValidPassword!1',
        password_confirmation: 'ValidPassword!1'
      )
    end

    it 'is valid with an email, password and password confirmation' do
      expect(@user).to be_valid
    end

    it "can't be deleted if it's the last user" do
      @user.save
      @user.destroy
      expect(@user.errors[:base]).to include 'Cannot delete last user'
    end

    describe 'field validation' do
      context 'password' do
        it 'has to be present when creating a new user' do
          @user.password = nil
          @user.valid?
          expect(@user.errors[:password]).to include('Nie podano hasła')
        end

        it 'can be nil when user is persisted to database' do
          @user.update(first_name: 'Andrzej')
          expect(@user).to be_valid
        end

        it 'has minumum of 8 characters' do
          @user.password = 'Short7!'
          @user.valid?
          expect(@user.errors[:password]).to(
            include('Hasło za krótkie (min 8 znaków)')
          )
        end

        it 'has maximum of 128 characters' do
          @user.password = SecureRandom.base64(100) # generates 136-char string
          @user.valid?
          expect(@user.errors[:password]).to(
            include('Hasło za długie (max 128 znaków)')
          )
        end

        it 'has an uppercase letter' do
          @user.password = 'password_without_uppercase_letter_1_!'
          @user.valid?
          expect(@user.errors[:password]).to(
            include(
              'Hasło musi mieć małą i dużą literę, cyfrę i znak specjalny'
            )
          )
        end

        it 'has a lowercase letter' do
          @user.password = 'PASSWORD_WITHOUT_LOWERCASE_LETTER_1_!'
          @user.valid?
          expect(@user.errors[:password]).to(
            include(
              'Hasło musi mieć małą i dużą literę, cyfrę i znak specjalny'
            )
          )
        end

        it 'has a number' do
          @user.password = 'Password_without_a_number_!'
          @user.valid?
          expect(@user.errors[:password]).to(
            include(
              'Hasło musi mieć małą i dużą literę, cyfrę i znak specjalny'
            )
          )
        end

        it 'has a special character (#?!@$%^&*-/\=)' do
          @user.password = 'Passwordwithoutspecialchar1'
          @user.valid?
          expect(@user.errors[:password]).to(
            include(
              'Hasło musi mieć małą i dużą literę, cyfrę i znak specjalny'
            )
          )
        end
      end

      context 'email' do
        it 'has to be present when creating a new user' do
          user = User.new
          user.valid?
          expect(user.errors[:email]).to(
            include('Proszę wpisać adres email')
          )
        end

        it 'is invalid in an incorrect format' do
          @user.email = 'wrongformat'
          @user.valid?
          expect(@user.errors[:email]).to(
            include('Podano nieprawidłowy adres e-mail')
          )
        end

        it 'can be blank when user is persisted to database' do
          @user.save
          @user.update(first_name: 'Andrzej')
          expect(@user).to be_valid
        end

        it 'is case sensitive' do
          @user.save
          other_user = User.new(
            email: 'ADMIN@ADMIN.COM',
            password: 'ValidPassword!1',
            password_confirmation: 'ValidPassword!1'
          )
          other_user.valid?
          expect(other_user.errors[:email]).to(
            include('Podany adres e-mail jest już zajęty')
          )
        end

        it 'has to be unique' do
          @user.save
          other_user = User.new(
            email: 'admin@admin.com',
            password: 'ValidPassword!1',
            password_confirmation: 'ValidPassword!1'
          )
          other_user.valid?
          expect(other_user.errors[:email]).to(
            include('Podany adres e-mail jest już zajęty')
          )
        end
      end
    end

    it 'sets random password' do
      @user.set_random_password
      expect(@user.password.length).to eq 128
    end

    it 'sets password creation token' do
      initial_token_value = @user.reset_password_token
      @user.set_pass_creation_token
      token_set_up = @user.reset_password_token
      expect(initial_token_value).not_to eq token_set_up
    end

    it 'generates string with listed roles' do
      @user.roles = %i[menu_editor comment_approver]
      expect(@user.roles_view).to(
        eq 'Zarządzanie strukturą menu, Obsługa komentarzy (moderowanie)'
      )
    end

    describe "returns user's name as a string" do
      context 'when there is a first name and a last name' do
        it 'returns a string with first and last name separated by a space' do
          @user.first_name = 'Andrzej'
          @user.last_name = 'Nowak'
          expect(@user.name_view).to eq 'Andrzej Nowak'
        end
      end

      context 'when there is only a last name present' do
        it 'returns a string with a last name' do
          @user.last_name = 'Nowak'
          expect(@user.name_view).to eq 'Nowak'
        end
      end

      context 'when there is only a first name present' do
        it 'returns a string with a first name' do
          @user.first_name = 'Andrzej'
          expect(@user.name_view).to eq 'Andrzej'
        end
      end
    end

    it 'checks if has given role' do
      @user.roles = :comment_approver
      expect(@user.has_role?(:comment_approver)).to be true
    end
  end
end
