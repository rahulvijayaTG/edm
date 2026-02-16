import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAppSelector, useAppDispatch } from '../../hooks/useAppDispatch';
import { updateQuantity, removeFromCart, clearCart } from '../../store/slices/cartSlice';
import { orderApi } from '../../api/orderApi';

const CartPage: React.FC = () => {
  const { items } = useAppSelector((state) => state.cart);
  const { user } = useAppSelector((state) => state.auth);
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const [address, setAddress] = useState('');
  const [ordering, setOrdering] = useState(false);
  const [showCheckout, setShowCheckout] = useState(false);
  const [error, setError] = useState('');

  const total = items.reduce((sum, i) => sum + i.product.price * i.quantity, 0);

  const handleCheckout = async () => {
    if (!address || address.length < 10) {
      setError('Please enter a valid shipping address (min 10 characters)');
      return;
    }
    setOrdering(true);
    setError('');
    try {
      await orderApi.createOrder({
        items: items.map((i) => ({ productId: i.product.id, quantity: i.quantity })),
        shippingAddress: address,
      });
      dispatch(clearCart());
      navigate('/my-orders');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to place order');
    }
    setOrdering(false);
  };

  if (items.length === 0) {
    return (
      <div className="cart-container">
        <div className="page-header">
          <h1>Shopping Cart</h1>
        </div>
        <div className="empty-state">
          <div className="icon">&#128722;</div>
          <h3>Your cart is empty</h3>
          <p>Browse products and add them to your cart</p>
          <Link to="/" className="btn btn-primary" style={{ marginTop: 16 }}>Browse Products</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="cart-container">
      <div className="page-header">
        <h1>Shopping Cart ({items.length} items)</h1>
      </div>
      <div className="card">
        {items.map((item) => (
          <div className="cart-item" key={item.product.id}>
            <div className="cart-item-info">
              <h4>{item.product.name}</h4>
              <div className="price">${item.product.price.toFixed(2)} each</div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
              <div className="quantity-selector">
                <button onClick={() => dispatch(updateQuantity({ productId: item.product.id, quantity: item.quantity - 1 }))}>-</button>
                <span>{item.quantity}</span>
                <button onClick={() => dispatch(updateQuantity({ productId: item.product.id, quantity: item.quantity + 1 }))}>+</button>
              </div>
              <strong>${(item.product.price * item.quantity).toFixed(2)}</strong>
              <button className="btn btn-sm btn-danger" onClick={() => dispatch(removeFromCart(item.product.id))}>Remove</button>
            </div>
          </div>
        ))}

        <div className="cart-summary">
          <div className="total">Total: ${total.toFixed(2)}</div>

          {!user && (
            <div>
              <p style={{marginBottom: 12, color: '#666'}}>Please login as a customer to checkout</p>
              <Link to="/login" className="btn btn-primary">Login to Checkout</Link>
            </div>
          )}

          {user && user.role === 'customer' && !showCheckout && (
            <button className="btn btn-primary" onClick={() => setShowCheckout(true)}>
              Proceed to Checkout
            </button>
          )}

          {user && user.role !== 'customer' && (
            <p style={{color: '#666'}}>Only customers can place orders. Please login as a customer.</p>
          )}

          {showCheckout && (
            <div style={{ marginTop: 20 }}>
              {error && <div className="error-message">{error}</div>}
              <div className="form-group">
                <label>Shipping Address</label>
                <textarea
                  className="form-control form-control-textarea"
                  value={address}
                  onChange={(e) => setAddress(e.target.value)}
                  placeholder="Enter your full shipping address"
                />
              </div>
              <div style={{ display: 'flex', gap: 12 }}>
                <button className="btn btn-primary" onClick={handleCheckout} disabled={ordering}>
                  {ordering ? 'Placing order...' : 'Place Order'}
                </button>
                <button className="btn btn-secondary" onClick={() => setShowCheckout(false)}>Cancel</button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default CartPage;
