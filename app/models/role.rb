# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :destroy

  def self.admin
    Role.find_by_name('Admin')
  end

  def self.gerente
    Role.find_by_name('Gerente')
  end

  def self.usuario
    Role.find_by_name('Usuário')
  end
end
