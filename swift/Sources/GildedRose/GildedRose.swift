import Cocoa
public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        
        for i in 0 ..< items.count {
            
            let name = extractNames(item: items[i])
            if name != "Sulfuras"{
                items[i] = updateItem(item: items[i], name: name)
            }
        }
    }
    
    private func updateItem(item: Item, name: String) -> Item{
        
        var quality = newItemQuality(item: item, name: name)

        quality = checkQualityBoundary(quality: quality)
        
        item.quality = quality
        item.sellIn = newItemSellIn(item: item, name: name)
        
        return item
    }
    
    private func newItemQuality(item: Item, name: String) -> Int{
        
        let sellByDatePassed = item.sellIn <= 0
        
        switch(name){
            
            case "Aged Brie":
                return item.quality + 1
                
            case "Backstage passes":
                return newBackstageQuantity(item: item, quality: item.quality)
                
            case "Conjured":
                return item.quality - (sellByDatePassed ? 4 : 2)
                
            case "Sulfuras":
                return item.quality
                
            default:
                return item.quality - (sellByDatePassed ? 2 : 1)
            
        }
    }
    
    private func newBackstageQuantity(item: Item, quality: Int) -> Int{
        
        switch item.sellIn{
            
            case 11...:
                return quality + 1
                
            case 6...10:
                return quality + 2
                
            case 1...5:
                return quality + 3
                
            default:
                return 0
        }
    }

    
    private func newItemSellIn(item: Item, name: String) -> Int{
        
        return item.sellIn - 1
    }
    
    private func extractNames(item: Item) -> String{
        
        let name = item.name
        
        if name.contains("Backstage passes"){
            return "Backstage passes"
        }
        
        else if name.contains("Conjured"){
            return "Conjured"
        }
        
        else if name.contains("Sulfuras"){
            return "Sulfuras"
        }
        
        else{
            return name
        }
    }
    
    private func checkQualityBoundary(quality: Int) -> Int{
        
        if quality > 50{
            return 50
        }
        
        else if quality < 0{
            return 0
        }
        
        else{
            return quality
        }
    }
}
