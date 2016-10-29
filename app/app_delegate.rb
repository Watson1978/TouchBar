class WindowController < NSWindowController
  WindowControllerLabelIdentifier = "com.yourcompany.TouchBar.label"

  def makeTouchBar
    touchBar = NSTouchBar.new
    touchBar.delegate = self
    touchBar.defaultItemIdentifiers = [:sushi]
    touchBar
  end

  def touchBar(touchBar, makeItemForIdentifier:identifier)
    case identifier
    when :sushi
      item = NSCustomTouchBarItem.alloc.initWithIdentifier(WindowControllerLabelIdentifier)
      item.view = NSTextField.labelWithString("🍣🍣🍣")
      return item
    end

    return nil
  end
end

class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow

    # TouchBarDelegate requires NSWindowController (or other controller)
    @controller = WindowController.alloc.initWithWindow(@mainWindow)
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end

end
