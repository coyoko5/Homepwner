//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Jin on 16/9/27.
//  Copyright © 2016年 ETONE. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic,strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController


#pragma mark ---------------------------
#pragma mark -Actions
//Other methods here
-(IBAction)addNewItem:(id)sender
{
    //创建新的BNRItem对象
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

//-(IBAction)toggleEditingMode:(id)sender
//{
//    //If you are currently in editing mode...
//    if (self.isEditing)
//    {
//        //修改按钮文字,提示用户当前的表格状态
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        //关闭编辑模式
//        [self setEditing:NO animated:YES];
//    }else
//    {
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

//-(UIView *)headerView
//{
//    //If you have not loaded the headerView yet...
//    if (!_headerView) {
//        //Load headerView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

#pragma mark ---------------------------
#pragma mark -Controller life cycle
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(instancetype)init
{
    //Call the supeclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
//        for(int i=0;i<5;i++)
//        {
//            [[BNRItemStore sharedStore] createItem];
//        }
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        //Create a new bar button item that will send
        //addItem:to BNRItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        //Set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

#pragma mark ---------------------------
#pragma mark -View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    
//    UIView *header = self.headerView;
//    [self.tableView setTableHeaderView:header];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark ---------------------------
#pragma mark -Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Create an instance of UITableViewCell,with default appearance
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items,where n = row this cell
    //will appear in on the tableView
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark ---------------------------
#pragma mark -Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailVC = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectItem = items[indexPath.row];
    
    //Give detail view controller a pointer to the item object in row
    detailVC.item = selectItem;
    
    //push it to the top of the navigation controller's stack
    [self.navigationController pushViewController:detailVC animated:YES];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
