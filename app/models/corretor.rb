# encoding: utf-8
class Corretor < PessoaFisica
  
  default_scope :conditions => {:tipo => CORRETOR}
  
  has_many :imovels
  #has_one :pessoa_fisica, dependent: :destroy
  has_one :user, dependent: :destroy
  
  has_and_belongs_to_many :mensagems
  
  accepts_nested_attributes_for :user, :allow_destroy => true
  
  validates :creci, :presence => { :message => "CRECI não pode ficar em branco." }
  
  attr_accessible :creci, :user_attributes

  #before_save :conferir_dados
  validate :conferir_dados
  
  # Usado para preencher o número creci com 5 digitos.
  def conferir_dados
    
    # Se o número creci for menor que 6, ele está incompleto
    #{ message: "ja foi cadastrada."}
    if creci.to_s == 0
      errors[:base] = "O CRECI "+creci.to_s+ " não é válido." if creci.length != 6
    end
    return creci.length == 6
    #if creci.length <= 6
      #self.creci = "0"+creci      
    #end
    
    
  end
end
