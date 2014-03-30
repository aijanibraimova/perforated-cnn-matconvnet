for l=3
  switch l
    case 1
      disp('testing gloss') ;
      n = 10 ;
      x = rand(n,1) ;
      c = 3 ;
      y = gloss(x,c) ;
      dzdy = randn(size(y)) ;
      dzdx = gloss(x,c,dzdy) ;
      testder(@(x) gloss(x,c), x, dzdy, dzdx) ;
      
    case 2
      disp('testing gsoftmax') ;
      n = 10 ;
      delta = 1e-6 ;
      x = randn(n,1) ;
      y = gsoftmax(x) ;
      dzdy = randn(size(y))
      dzdx = gsoftmax(x, dzdy) ;
      testder(@(x) gsoftmax(x), x, dzdy, dzdx) ;
      
    case 3
      disp('testing gfully') ;
      m = 10;
      n = 15 ;
      x = randn(n,1) ;
      w = randn(m,n) ;
      y = gfully(x,w) ;
      dzdy = randn(size(y))
      [dzdx,dzdw] = gfully(x,w,dzdy) ;
      testder(@(x) gfully(x,w), x, dzdy, dzdx) ;
      testder(@(w) gfully(x,w), w, dzdy, dzdw) ;
      
    case 4
      disp('testing gconv') ;
      x = randn(16,10,4,2,'single') ;
      w = randn(3,3,4,5,'single') ;
      y = gconv(x,w) ;
      dzdy = randn(size(y),'single') ;
      [dzdw,dzdx] = gconv(x,w,dzdy) ;
      testder(@(x) gconv(x,w), x, dzdy, dzdx) ;
      testder(@(w) gconv(x,w), w, dzdy, dzdw) ;
      
    case 5
      disp('testing gpool') ;
      x = randn(5,4,3,2,'single') ;
      % make sure that all elements in x are different. in this way,
      % we can compute numerical derivatives reliably by adding a delta < .5.
      x(:) = randperm(numel(x))' ;
      y = gpool(x,[3,3]) ;
      dzdy = randn(size(y),'single') ;
      dzdx = gpool(x,[3,3],dzdy) ;
      testder(@(x) gpool(x,[3,3]), x, dzdy, dzdx) ;
      
    case 6
      disp('testing gnormalize') ;
      param = [3, .1, .5, .75] ;
      x = randn(3,2,10,4,'single') ;
      y = gnormalize(x,param) ;
      dzdy = randn(size(y),'single') ;
      dzdx = gnormalize(x,param,dzdy) ;
      testder(@(x) gnormalize(x,param), x, dzdy, dzdx) ;
      
    case 7
      disp('testing gvec') ;
      x = randn(3,2,10,4,'single') ;
      y = gvec(x) ;
      dzdy = randn(size(y),'single') ;
      dzdx = gvec(x,dzdy) ;
      testder(@(x) gvec(x), x, dzdy, dzdx) ;
      
    case 8
      disp('testing relu') ;
       x = randn(5,5,1,1,'single') ;
      % make sure that all elements in x are different. in this way,
      % we can compute numerical derivatives reliably by adding a delta < .5.
      x(:) = randperm(numel(x))' - round(numel(x)/2) ;
      % avoid non-diff value for test
      x(x==0)=1 ;
      y = grelu(x) ;
      dzdy = randn(size(y),'single') ;
      dzdx = grelu(x,dzdy) ;
      testder(@(x) grelu(x), x, dzdy, dzdx) ;
  end
end

        