class Service < ActiveRecord::Base
	validates_numericality_of :code, even: true
	validates_uniqueness_of :code

	after_save :save_code_out

	def save_code_out
		retorno = self.code.to_i + 1
		self.update_column(:code_out, retorno)
	end
end
