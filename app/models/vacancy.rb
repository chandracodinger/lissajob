class Vacancy < ApplicationRecord
	validates_presence_of :title,:salary,:requipment,:description,:expired
end
