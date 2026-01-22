# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Criando zonas de entrega..."

delivery_zones = [
  { neighborhood: "Centro", fee_cents: 500, estimated_minutes: 20 },
  { neighborhood: "Jardim América", fee_cents: 600, estimated_minutes: 25 },
  { neighborhood: "Vila Mariana", fee_cents: 700, estimated_minutes: 30 },
  { neighborhood: "Pinheiros", fee_cents: 650, estimated_minutes: 25 },
  { neighborhood: "Moema", fee_cents: 800, estimated_minutes: 35 },
  { neighborhood: "Itaim Bibi", fee_cents: 750, estimated_minutes: 30 },
  { neighborhood: "Consolação", fee_cents: 550, estimated_minutes: 20 },
  { neighborhood: "Liberdade", fee_cents: 500, estimated_minutes: 15 },
  { neighborhood: "Bela Vista", fee_cents: 500, estimated_minutes: 15 },
  { neighborhood: "Vila Madalena", fee_cents: 700, estimated_minutes: 30 },
  { neighborhood: "Perdizes", fee_cents: 800, estimated_minutes: 35 },
  { neighborhood: "Santana", fee_cents: 900, estimated_minutes: 40 },
  { neighborhood: "Tatuapé", fee_cents: 1000, estimated_minutes: 45 },
  { neighborhood: "Brooklin", fee_cents: 850, estimated_minutes: 35 },
  { neighborhood: "Campo Belo", fee_cents: 900, estimated_minutes: 40 }
]

delivery_zones.each do |zone_attrs|
  DeliveryZone.find_or_create_by!(neighborhood: zone_attrs[:neighborhood]) do |zone|
    zone.fee_cents = zone_attrs[:fee_cents]
    zone.estimated_minutes = zone_attrs[:estimated_minutes]
    zone.active = true
  end
end

puts "#{DeliveryZone.count} zonas de entrega criadas!"
