require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'campo vazio' do
      it 'falso quando name está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'',code:'RIO',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando code está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando city está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIO',city:'',area:'60000',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando area está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIO',city:'Rio de Janeiro',area:'',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando zip está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIO',city:'Rio de Janeiro',area:'60000',
          zip:'',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando address está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIO',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando description está vazio' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIO',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'Copacabana',description:''
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
    end
    context 'regras específicas' do
      it 'falso quando code tem mais de 3 caracteres' do
        # Arrange
        warehouse = Warehouse.new(
          name:'Rio',code:'RIOO',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq false
      end
      it 'falso quando code já foi usado' do
        # Arrange
        first_warehouse = Warehouse.create(
          name:'Rio',code:'RIO',city:'Rio de Janeiro',area:'60000',
          zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
        )
        second_warehouse = Warehouse.new(
          name:'Niteroi',code:'RIO',city:'Niteroi',area:'50000',
          zip:'45689212',address:'Avenida',description:'Galpão na cidade'
        )
        # Act
        result = second_warehouse.valid?
        # Assert
        expect(result).to eq false
      end
    end
  end

  describe '#full_description' do
    it 'exibe nome e o código' do
      warehouse = Warehouse.new(
        name:'Galpão Litoral',code:'RIO',city:'Rio de Janeiro',area:'60000',
        zip:'72589685',address:'Copacabana',description:'Galpão no litoral'
      )

      result = warehouse.full_description

      expect(result).to eq('RIO | Galpão Litoral')
    end
  end
end
