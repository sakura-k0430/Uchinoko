class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  belongs_to :owner, class_name: 'Customer'
  has_many :customers, through: :group_customers, source: :customer

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def is_owned_by?(customer)
    owner.id == customer.id
  end

  # customerがグループのメンバーであるかどうかを判定するメソッドinclude
  def includesCustomer?(customer)
  group_customers.exists?(customer_id: customer.id)
  end

end
