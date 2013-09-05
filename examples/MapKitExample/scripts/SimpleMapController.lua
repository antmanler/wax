require "SimpleAnnotation"

waxClass{"SimpleMapController", UIViewController, protocols={"MKMapViewDelegate"}}

function init(self)
  self.super:init()

  self.location = {
    lat=31.23145,
    long=121.47651,
  }
  return self
end

function viewDidLoad(self)
  self.super:viewDidLoad()
  --create member 'mapView' dynamically
  self.mapView = MKMapView:initWithFrame(self:view():bounds())

  self.mapView:setScrollEnabled(true)
  
  --show user location
  self.mapView:setShowsUserLocation(true)
  
  --make delegate functions to be called
  self.mapView:setDelegate(self)

  local region = MKCoordinateRegion(self.location.lat, self.location.long, 0.02, 0.02)
  self.mapView:setRegion_animated(region, true)
  --MKUserTrackingModeFollow = 1
  --self.mapView:setUserTrackingMode(1)

  --local coodinate = CLLocation:CLLocationCoordinate2DMake(self.location.lat, self.location.long)
  --local user = mapView.userLocation
  --print(user)
  --local location = user:location()
  --print(location)
  --local coords = location:coordinate()
  --print(coords)
  local annotation = SimpleAnnotation:initWithLatLong(self.location.lat, self.location.long)
--  print(debug.getinfo(annotation.lat));
--  print(annotation.lat)
--  print(annotation.long)
--  print(annotatoin:title())
--  print(annotation:subtitle())
--  print(inspect(annotation))
--  print(self.location.lat.."    "..self.location.long)
  annotation:setTitle('title')
  annotation:setSubtitle('subtitle')
  self.mapView:addAnnotation(annotation)
  
  self:view():insertSubview_atIndex(self.mapView, 0)
  --timer = NSTimer:scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(1, self, "handleTimer:", nil, true)
end

--[[
function handleTimer()  
	--print('did enter handleTimer')

end
]] 

function mapView_regionWillChangeAnimated(self, mapView, animated)
	print('did enter mapView_regionWillChangeAnimated')
end

function mapView_regionDidChangeAnimated(self, mapView, animated)
	print('did enter mapView_regionDidChangeAnimated')
end

function mapView_didSelectAnnotationView(self, mapView)
	print('did enter mapView_didSelectAnnotationView')
end

function mapView_didDeselectAnnotationView(self, mapView)
	print('did enter mapView_didDeselectAnnotationView')
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function mapView_viewForAnnotation(self, mapView, annotation)
	print('did enter mapView_viewForAnnotation')
	--print(_VERSION)
	--print('datatype of "package" is '..type(package))
	--print('there are '..tablelength(package.loaded)..' loaded packages')
	--print(tablelength(package))
	--print('this program has runs about '..os.clock()..' seconds')
	--print('getenv returns '..os.getenv('USER'))

	if annotation:isKindOfClass(MKUserLocation:class()) then
		local location = annotation:location()
		local coords = location:coordinate()
		--local region = MKCoordinateRegion(coords.latitude, coords.longitude, 0.02, 0.02)
		--print(coords)
		--local span = MKCoordinateSpanMake(0.02, 0.02)
		--print(span)
		--local region = MKCoordinateRegionMake(coords, span)
  		--self.mapView:setRegion_animated(region, true)
		--[my_mapView setCenterCoordinate:my_mapView.userLocation.coordinate animated:YES];
		self.mapView:setCenterCoordinate_animated(coords, true)
		return nil
	elseif annotation:isKindOfClass(SimpleAnnotation:class()) then
		local identifier = 'pinIdentifier'
		local draggablePinView = mapView:dequeueReusableAnnotationViewWithIdentifier(identifier)
		
		draggablePinView = draggablePinView or MKPinAnnotationView:initWithAnnotation_reuseIdentifier(annotation, kPinAnnotationIdentifier);
		draggablePinView:setDraggable(true)
		draggablePinView:setCanShowCallout(true)
		draggablePinView:setAnimatesDrop(true)

		-- MKPinAnnotationColor
		--MKPinAnnotationColorRed = 0
		--MKPinAnnotationColorGreen = 1
		--MKPinAnnotationColorPurple = 2
		draggablePinView:setPinColor(1)

		return draggablePinView
	else
		print(annotation:class())
		return nil
	end
end
