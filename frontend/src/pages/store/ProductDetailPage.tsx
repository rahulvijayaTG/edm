import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { productApi } from '../../api/productApi';
import { Product } from '../../types';
import { useAppDispatch } from '../../hooks/useAppDispatch';
import { addToCart } from '../../store/slices/cartSlice';
import Loading from '../../components/common/Loading';

const ProductDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [product, setProduct] = useState<Product | null>(null);
  const [loading, setLoading] = useState(true);
  const [quantity, setQuantity] = useState(1);
  const [added, setAdded] = useState(false);
  const dispatch = useAppDispatch();

  useEffect(() => {
    if (!id) return;
    productApi.getProductById(id)
      .then((res) => setProduct(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [id]);

  const handleAddToCart = () => {
    if (!product) return;
    dispatch(addToCart({ product, quantity }));
    setAdded(true);
    setTimeout(() => setAdded(false), 2000);
  };

  if (loading) return <Loading />;
  if (!product) return <div className="empty-state"><h3>Product not found</h3></div>;

  return (
    <div>
      <Link to="/" style={{ color: '#e94560', marginBottom: 20, display: 'inline-block' }}>
        &larr; Back to products
      </Link>
      <div className="product-detail">
        <div className="product-detail-image">
          {product.images.length > 0 ? (
            <img src={product.images[0]} alt={product.name} style={{width: '100%', height: '100%', objectFit: 'cover', borderRadius: 16}} />
          ) : (
            product.name.charAt(0).toUpperCase()
          )}
        </div>
        <div className="product-detail-info">
          <h1>{product.name}</h1>
          <div className="price">${product.price.toFixed(2)}</div>
          <div className="meta">
            <span className="badge badge-info" style={{marginRight: 8}}>{product.category}</span>
            <span>{product.stock > 0 ? `${product.stock} in stock` : 'Out of stock'}</span>
          </div>
          <div className="description">{product.description}</div>

          {product.stock > 0 && (
            <>
              <div className="quantity-selector">
                <button onClick={() => setQuantity(Math.max(1, quantity - 1))}>-</button>
                <span>{quantity}</span>
                <button onClick={() => setQuantity(Math.min(product.stock, quantity + 1))}>+</button>
              </div>
              <button className="btn btn-primary" onClick={handleAddToCart}>
                {added ? 'Added to Cart!' : 'Add to Cart'}
              </button>
            </>
          )}
          {product.stock === 0 && (
            <button className="btn btn-secondary" disabled>Out of Stock</button>
          )}

          <div style={{ marginTop: 20 }}>
            <Link to={`/store/${product.vendorId}`} className="btn btn-outline btn-sm">
              Visit Store
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductDetailPage;
