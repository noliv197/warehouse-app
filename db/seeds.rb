Warehouse.create!(
    name: 'Maceio', code: 'MCZ',
    city: 'Maceio', area: 50000,
    address:'Avenida do Aeroporto',zip:'589467854',
    description:'Galpão destinado para cargas maritimas'
)
Warehouse.create!(
    name: 'Aeroporto Rio', code: 'SDU',
    city: 'Rio de Janeiro', area: 60000,
    address:'Avenida do Aeroporto',zip:'414444100',
    description:'Galpão destinado para cargas internacionais'
)
first_supplier = Supplier.create!(
    corporate_name: 'Galpões&CIA',brand_name:'GC',
    cnpj:'1234567899874',registration_number: '456871321',
    full_address: 'Avenida copacabana',city:'Rio de Janeiro',
    state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
)
second_supplier = Supplier.create!(
    corporate_name: 'Amazon',brand_name:'Amazon',
    cnpj:'9874563214568',registration_number: '89575213',
    full_address: 'Avenida central',city:'São Paulo',
    state:'SP',email:'amazon@gmail.com',phone:'(61)985472563'
)
ProductModel.create!(
    name:'TV 32',weight:8000,height:70,width:45,
    depth:10,sku:'TV32-SAMSU-TXP907895',supplier: first_supplier
)
ProductModel.create!(
    name:'Controle PS5',weight:20,height:30,width:30,
    depth:5,sku:'Controle-XSD25478985',supplier: second_supplier
)