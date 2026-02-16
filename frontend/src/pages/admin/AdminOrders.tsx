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

const AdminOrders: React.FC = () => {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    orderApi.getAllOrders()
      .then((res) => setOrders(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>All Orders</h1>
      </div>
      <div className="card">
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Items</th>
                <th>Total</th>
                <th>Status</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              {orders.map((o) => (
                <tr key={o.id}>
                  <td style={{fontSize: '0.8rem'}}>{o.id.slice(0, 8)}...</td>
                  <td>{o.items.map((i) => `${i.productName} x${i.quantity}`).join(', ')}</td>
                  <td><strong>${o.totalAmount.toFixed(2)}</strong></td>
                  <td><span className={`badge ${statusBadge(o.status)}`}>{o.status}</span></td>
                  <td>{new Date(o.createdAt).toLocaleDateString()}</td>
                </tr>
              ))}
              {orders.length === 0 && (
                <tr><td colSpan={5} style={{textAlign: 'center', padding: '40px'}}>No orders found</td></tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default AdminOrders;
