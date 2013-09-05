waxClass{"SimpleAnnotation", NSObject, protocols={"MKAnnotation"}}

function initWithLatLong(self, lat, long)
  self.super:init()
  self.lat = lat
  self.long = long
  -- These variables have underscores because they would have conflicted with 
  -- method names required by the MKAnnotation protocol.
  self.setTitle(self, 'Untitled')
  self.setSubtitle(self, 'Untitled')
  return self
end

function coordinate(self)
  return CLLocationCoordinate2D(self.lat, self.long)
end

function title(self)
  return self._title
end

function setTitle(self, title)
  self._title = title
end

function subtitle(self)
  return self._subtitle
end

function setSubtitle(self, subtitle)
  self._subtitle = subtitle
end
