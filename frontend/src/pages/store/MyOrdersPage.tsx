import React, { useEffect, useState } from 'react';
import { orderApi } from '../../api/orderApi';
import { Order } from '../../types';
import Loading from '../../components/common/Loading';

const statusBadge = (status: string) => {
  const map: Record<string, string> = {
    pending: 'badge-warning',
    confirmed: 'badge-info',
    shipped: 'badge-primary',
    delivered: 'badge-success',
    cancelled: 'badge-danger',
  };
  return map[status] || 'badge-info';
};

const MyOrdersPage: React.FC = () => {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    orderApi.getMyOrders()
      .then((res) => setOrders(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div style={{ maxWidth: 900, margin: '0 auto' }}>
      <div className="page-header">
        <h1>My Orders</h1>
      </div>
      {orders.length === 0 ? (
        <div className="empty-state">
          <div className="icon">&#128230;</div>
          <h3>No orders yet</h3>
          <p>Start shopping to see your orders here!</p>
        </div>
      ) : (
        orders.map((order) => (
          <div className="card" key={order.id}>
            <div className="card-header">
              <h3>Order #{order.id.slice(0, 8)}</h3>
              <span className={`badge ${statusBadge(order.status)}`}>{order.status}</span>
            </div>
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                  </tr>
                </thead>
                <tbody>
                  {order.items.map((item, idx) => (
                    <tr key={idx}>
                      <td>{item.productName}</td>
                      <td>{item.quantity}</td>
                      <td>${item.price.toFixed(2)}</td>
                      <td>${(item.price * item.quantity).toFixed(2)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div style={{ marginTop: 12, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span style={{ color: '#777', fontSize: '0.85rem' }}>
                {new Date(order.createdAt).toLocaleDateString()} | {order.shippingAddress}
              </span>
              <strong style={{ fontSize: '1.1rem', color: '#e94560' }}>Total: ${order.totalAmount.toFixed(2)}</strong>
            </div>
          </div>
        ))
      )}
    </div>
  );
};

export default MyOrdersPage;
