# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :destroy

  def self.admin
    Role.find_by_name('Admin')
  end

  def self.manager
    Role.find_by_name('Gerente')
  end

  def self.user
    Role.find_by_name('Usuário')
  end
end
