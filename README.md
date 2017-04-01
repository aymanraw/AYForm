# AYForm

## How To Use:

`let form = AYForm(numberOfSections: 4)`

`form.addFields(cellIdentifier: "FieldTableViewCell", forSection: 0, outputs: ("titleField", "title"), ("subTitleField", "subTitle"))`

### Delegates:

func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, field: Any) {
        
     
  }
    
 func form(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
 
      return nil
 }
    
func form(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

    return nil
 }
