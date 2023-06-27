class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == SULFURAS
      if item.name == AGED_BRIE
        specialized_item = AgedBrieItem.new(item)
        specialized_item.update_quality
        next
      end
      if item.name == BACKSTAGE_PASSES
        specialized_item = BackstagePassesItem.new(item)
        specialized_item.update_quality
        next
      end
      specialized_item = RegularItem.new(item)
      specialized_item.update_quality
    end
  end
end

class RegularItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update_quality()
    if @item.quality > 0
      @item.quality = @item.quality - 1
    end
    @item.sell_in = @item.sell_in - 1
    if @item.sell_in < 0
      if @item.quality > 0
        @item.quality = @item.quality - 1
      end
    end
  end
end

class BackstagePassesItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update_quality()
    if item.quality < 50
      item.quality = item.quality + 1
      if item.sell_in < 11
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end
end

class AgedBrieItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update_quality()
    if item.quality < 50
      item.quality = item.quality + 1
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
