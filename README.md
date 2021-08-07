##NASA-App

An app created to search NASA images based on NASA events or space items. Users search images by utilizing the seachbar. They can also find more information about the image if they tap on the image, which leads them to a detail page.

##DEMO

This is an example of how a user can search up images and access the details based on that image.

![gif](https://user-images.githubusercontent.com/55721710/128612161-9b84e072-5a4e-496a-abae-1714bb57b7f4.mp4)

This is an example search.

<img width="346" alt="search" src="https://user-images.githubusercontent.com/55721710/128612345-4f7dc309-d213-420b-ab62-17646ff1934a.png">

This is an example detail view.

<img width="354" alt="detail" src="https://user-images.githubusercontent.com/55721710/128612346-77bb8d9e-1434-4a49-96bf-0ca84fcc65a8.png">


This app includes pagination, which allows users to continously access "new" photos. 

![gif](https://user-images.githubusercontent.com/55721710/128612441-82048be2-e3ad-478c-be03-5939530fae61.mp4)

##CODE SNIPPET

This block of code shows the implementation of pagation based on pages that the NASA API gives access to. 

```
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not return ImageCell")
        }
        
        let item = collection[indexPath.row]
        
        cell.imageView.layer.cornerRadius = 10
        collectionViewCellShadowSetup(cell: cell)
        
        if let link = item.links?.first?.href {
            cell.configureCell(with: link)
        }
        
        //checks current row to see if it's the last item within the collection to add data onto the current data array for pagination
        if indexPath.row == collection.count - 1 {
            page += 1

            search(searchText: searchText, page: page)
        }
        
        return cell
    }
```



