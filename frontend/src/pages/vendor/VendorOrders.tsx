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

const VendorOrders: React.FC = () => {
  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchOrders = () => {
    setLoading(true);
    orderApi.getVendorOrders()
      .then((res) => setOrders(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  };

  useEffect(() => { fetchOrders(); }, []);

  const handleStatusUpdate = async (orderId: string, status: string) => {
    try {
      await orderApi.updateOrderStatus(orderId, status);
      fetchOrders();
    } catch (err) {
      console.error(err);
    }
  };

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Orders</h1>
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
                <th>Address</th>
                <th>Date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {orders.map((o) => (
                <tr key={o.id}>
                  <td style={{fontSize: '0.8rem'}}>{o.id.slice(0, 8)}...</td>
                  <td>{o.items.map((i) => `${i.productName} x${i.quantity}`).join(', ')}</td>
                  <td><strong>${o.totalAmount.toFixed(2)}</strong></td>
                  <td><span className={`badge ${statusBadge(o.status)}`}>{o.status}</span></td>
                  <td style={{fontSize: '0.85rem', maxWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap'}}>{o.shippingAddress}</td>
                  <td>{new Date(o.createdAt).toLocaleDateString()}</td>
                  <td>
                    <select
                      className="form-control"
                      style={{ padding: '4px 8px', fontSize: '0.8rem', width: 'auto' }}
                      value={o.status}
                      onChange={(e) => handleStatusUpdate(o.id, e.target.value)}
                    >
                      <option value="pending">Pending</option>
                      <option value="confirmed">Confirmed</option>
                      <option value="shipped">Shipped</option>
                      <option value="delivered">Delivered</option>
                      <option value="cancelled">Cancelled</option>
                    </select>
                  </td>
                </tr>
              ))}
              {orders.length === 0 && (
                <tr><td colSpan={7} style={{textAlign: 'center', padding: '40px'}}>No orders yet</td></tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default VendorOrders;
